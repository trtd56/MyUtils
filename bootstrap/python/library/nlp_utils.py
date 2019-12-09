import MeCab
import emoji
import mojimoji
import re
from nltk import ngrams
import spacy
from spacy import displacy


nlp = spacy.load('ja_ginza')
default_t = MeCab.Tagger("-Ochasen")
neologd_t = MeCab.Tagger(" -d /opt/mecab/lib/mecab/dic/mecab-ipadic-neologd")
emoji_lst = emoji.UNICODE_EMOJI
DEF_URL_TAG = "URL"
DEF_EMOJI_TAG = "EMOJI"


def analysis_mecab(text, is_neologd=False):

    def _sep(text):
        tagger = neologd_t if is_neologd else default_t
        return [t for t in tagger.parse(text).split('\n')
                if t not in ["", "EOS"]]

    lst = [t.split("\t") for t in _sep(text)]

    if is_neologd:
        lst = [[s[0]] + s[1].split(",") for s in lst]

    return lst


def sep_by_mecab(text, is_neologd=False, org_form=False):
    if is_neologd:
        idx = 7 if org_form else 0
    else:
        idx = 2 if org_form else 0
    wakati = analysis_mecab(text, is_neologd)
    return [w[idx] for w in wakati]


def get_pos(text, is_neologd=False):
    wakati = analysis_mecab(text, is_neologd=is_neologd)
    if is_neologd:
        pos = [w[1] for w in wakati]
    else:
        pos = [w[3].split("-")[0] for w in wakati]
    return pos


def norm_url(text, url_tag=DEF_URL_TAG):
    url_pattern = r"https?://[\w/:%#\$&\?\(\)~\.=\+\-…]+"
    return re.sub(url_pattern, url_tag, text)


def norm_numeric(text):
    w_lst = sep_by_mecab(text)
    return "".join(["0" if w.isnumeric() else w for w in w_lst])


def norm_emoji(text, emoji_tag=DEF_EMOJI_TAG):
    return "".join([emoji_tag if t in emoji_lst else t for t in text])


def nchars(s, n):
    assert n > 0
    reg = re.compile("(.)\\1{%d,}" % (n - 1))
    while True:
        m = reg.search(s)
        if not m:
            break
        yield m.group(0)
        s = s[m.end():]


def is_continuous_char(text, count):
    c_lst = list(nchars(text, count))
    return len(c_lst) > 0


def is_continuous_word(text, count, org_form=False):
    w_lst = sep_by_mecab(text, org_form)
    e_lst = list(ngrams(w_lst, count))
    return sum([len(set(e)) == 1 for e in e_lst]) != 0


def norm_continuous_char(text, count=3):
    c_lst = list(nchars(text, count))
    for c in c_lst:
        text = text.replace(c, c[0])
    return text


def normalize_text(text):
    text = str(text)
    text = text.lower()  # all lower
    text = mojimoji.zen_to_han(text)  # all hankaku
    text = norm_numeric(text)
    text = norm_emoji(text)
    text = norm_url(text)
    text = norm_continuous_char(text)
    return text


def aster2mask(text):
    return re.sub("(\*){2,}", " [MASK]", text)


def norm_ner(text, ners=["DATE", "MONEY"]):
    doc = nlp(text)
    for ent in doc.ents:
        if ent.label_ in ners:
            text = text.replace(ent.text, f"[{ent.label_}]")


def get_tokens(text):
    doc = nlp(text)
    try:
        sent = [sent for sent in doc.sents][0]
    except IndexError:
        return None, None
    root_head_i = [token.head.i for token in sent if token.dep_ == "ROOT"][0]
    return sent, root_head_i


def is_want_text(sent, root_head_i):
    return  len([token.lemma_ for token in sent if token.head.i == root_head_i and token.lemma_ in ["たい"]]) > 0


def is_not_text(sent, root_head_i):
    return  len([token.lemma_ for token in sent if token.head.i == root_head_i and token.lemma_ in ["ない", "ず"]]) > 0


def is_q_text(sent, root_head_i):
    return  len([token.lemma_ for token in sent if token.head.i == root_head_i and token.lemma_ in ["か"]]) > 0


def is_use_text(text):
    sent, root_head_i = get_tokens(text)
    if sent is None:
        return False
    is_q = is_q_text(sent, root_head_i)
    is_not = is_not_text(sent, root_head_i)
    is_want = is_want_text(sent, root_head_i)
    return is_q or is_not or is_want


def get_words_info_ginza(text, plot=False):
    doc = nlp(text)
    for sent in doc.sents:
        for token in sent:
            print(token.i, token.orth_, token.lemma_, token.pos_, token.tag_, token.dep_, token.head.i)
        print('EOS')
    if plot:
        displacy.serve(doc, style="dep")
