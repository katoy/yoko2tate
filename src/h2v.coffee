###
# See http://www.openspc2.org/reibun/javascript/business/003/
#     > 半角カナから全角カナへ変換する（濁点等対応版）
# 
#     http://yubais.net/tatetwi/
#     > 縦書きツイート作成ツール。
#
#  $ coffee -p /h2v.coffee として h2j.js を生成している。
###

KANA_HAN = "ｱｲｳｴｵｶｷｸｹｺｻｼｽｾｿﾀﾁﾂﾃﾄﾅﾆﾇﾈﾉﾊﾋﾌﾍﾎﾏﾐﾑﾒﾓﾔﾕﾖﾗﾘﾙﾚﾛﾜｦﾝｧｨｩｪｫｬｭｮｯ､｡ｰ｢｣ﾞﾟ"
KANA_ZEN = "" +
  "アイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモヤユヨラリルレロワヲンァィゥェォャュョッ、。ー「」" +
  "　　　　　ガギグゲゴザジズゼゾダヂヅデド　　　　　バビブベボ　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　" +
  "　　　　　　　　　　　　　　　　　　　　　　　　　パピプペポ　　　　　　　　　　　　　　　　　　　　　　　　　　　　　"
# 半角仮名文字を全角に変換する
toZenkakuKANAHIRA = (str) ->
  ans = ''
  len = str.length
  for i in [0 ... len]
    c = str.charAt(i)
    cnext = str.charAt(i+1)
    n = KANA_HAN.indexOf(c)
    nnext = KANA_HAN.indexOf(cnext)
    if (n >= 0)
      if (nnext == 60)
        c = KANA_ZEN.charAt(n+60)
        i++
      else if (nnext == 61)
        c = KANA_ZEN.charAt(n+120)
        i++
      else
        c = KANA_ZEN.charAt(n);
    ans += c if (n != 60) and (n != 61)      
  ans

HAN = ' 1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!"#$%&()=-|~\\[]{}<>,.?/_\''
ZEN = '　１２３４５６７８９０ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ！”＃＄％＆（）＝－｜～￥［］｛｝＜＞、．？／＿’'
# 半角英数字を全角に変換する
toZenkakuASCII = (str) ->
  ans = ''
  for c in str
    p = HAN.indexOf(c)
    ans += if p >= 0 then ZEN.charAt(p) else c
  ans

# 縦書き・横書きに特化した文字の変換を行う。―
TRANS_H = "-|→↑←↓｜ー−―‐｜｜｜｜"                # 長音 ー, マイナス −, ハイフン ‐
TRANS_V = "|-↓→↑←ー｜｜｜｜ー−―‐"

toZenkaku = (str) ->  toZenkakuASCII(toZenkakuKANAHIRA(str))

text2lines = (text) -> text.split("\n")
lines2text = (lines) -> lines.join("\n")

reverseStr = (str) ->  str.split("").reverse().join("")
reverseLines = (lines) -> lines.reverse()
reverseText = (text) -> text.split("\n").reverse().join("\n")

class H2V
  # 横書きを縦書きに変換する。半角文字は全角に変換する。
  @h2vText: (text) -> H2V.h2vLines(text2lines(text)).join("\n")
  @h2vLines: (lines) ->
    # 改行記号で分画して、行の順番を反転する。
    lines = reverseLines(lines)
    # 各業を全角化する
    lines = (toZenkaku(line) for line in lines) 

    max_len = Math.max.apply(null, (str.length for str in lines) )
    num_line = lines.length

    # 各行の長さを同じにする
    for line,idx in lines
      lines[idx] += "　" for i in [0 ... (max_len - line.length)]

    # 縦書きで文字を配置していく
    ans = ("" for y in [0 ... max_len])

    for i in [0 ... num_line]
      for c,idx in lines[i]
        ans[idx] += c
    ans

  # 縦書きを横描きに変換する。半角文字は全角に変換する。
  @v2hText: (text) -> H2V.v2hLines(text2lines(text)).join("\n")
  @v2hLines: (lines) ->
    # 単純に横書きに変換して、各行を反転する
    lines = H2V.h2vLines(lines)
    lines[idx] = reverseStr(line) for line,idx in lines
    lines.reverse()

  # 文字を置換する。
  @transStr: (str, fromStr, toStr) ->
    ans = ''
    for c in str
      p = fromStr.indexOf(c)
      ans += if p >= 0 then toStr.charAt(p) else c
    ans

  # 横書き -> 縦書き時に矢印記号を置き換える  
  @transStrH2V: (str, fromStr = TRANS_H, toStr = TRANS_V) -> H2V.transStr(str, fromStr, toStr)
  # 縦書き -> 横書き時に矢印記号を置き換える  
  @transStrV2H: (str, fromStr = TRANS_V, toStr = TRANS_H) -> H2V.transStr(str, fromStr, toStr)

  # 出力したテキストをツイートする URLを得る。
  @get_tweetURL = (content) ->
    encoded = encodeURIComponent(content)
    url = "https://twitter.com/intent/tweet?text=#{encoded}"

if module?.exports  # Node.jsの場合
  module.exports = H2V
else  # ブラウザの場合
  @H2V = H2V

