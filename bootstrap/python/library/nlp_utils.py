import MeCab
import emoji
import mojimoji
import re
from nltk import ngrams

tagger = MeCab.Tagger("-Ochasen")
emoji_lst = emoji.UNICODE_EMOJI


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


def replace_regex(pattern, org, new):
    return re.sub(pattern, org, new)


def norm_url(text, url_tag="URL"):
    url_patern = r"https?://[\w/:%#\$&\?\(\)~\.=\+\-…]+"
    return replace_regex(url_patern, text, url_tag)


def norm_numeric(text):
    w_lst = sep_by_mecab(text)
    return "".join(["0" if w.isnumeric() else w for w in w_lst])


def norm_emoji(text, emoji_tag="EMOJI"):
    return "".join([emoji_tag if t in emoji_lst else t for t in text])


def zen_to_han(text):
    return mojimoji.zen_to_han(text)


def ngram(lst, n):
    return [i for i in ngrams(lst, n)]


def is_continuous_elem(lst, count):
    e_lst = ngram(lst, count)
    return sum([len(set(e)) == 1 for e in e_lst]) != 0
