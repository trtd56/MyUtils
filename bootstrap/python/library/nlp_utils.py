import MeCab
import emoji
import mojimoji
import re
from nltk import ngrams

tagger = MeCab.Tagger("-Ochasen")
emoji_lst = emoji.UNICODE_EMOJI
DEF_URL_TAG = "URL"
DEF_EMOJI_TAG = "EMOJI"


def analysis_mecab(text):
    lst = [
            t.split("\t")
            for t in tagger.parse(text).split('\n')
            if t not in ["", "EOS"]
    ]
    return lst


def sep_by_mecab(text, org_form=False):
    idx = 2 if org_form else 0
    wakati = analysis_mecab(text)
    return [w[idx] for w in wakati]


def get_pos(text):
    wakati = analysis_mecab(text)
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
