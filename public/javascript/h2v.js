// Generated by CoffeeScript 1.6.3
/*
# See http://www.openspc2.org/reibun/javascript/business/003/
#     > 半角カナから全角カナへ変換する（濁点等対応版）
# 
#     http://yubais.net/tatetwi/
#     > 縦書きツイート作成ツール。
#
#  $ coffee -p /h2v.coffee として h2j.js を生成している。
*/


(function() {
  var H2V, HAN, KANA_HAN, KANA_ZEN, TRANS_H, TRANS_V, ZEN, lines2text, reverseLines, reverseStr, reverseText, text2lines, toZenkaku, toZenkakuASCII, toZenkakuKANAHIRA;

  KANA_HAN = "ｱｲｳｴｵｶｷｸｹｺｻｼｽｾｿﾀﾁﾂﾃﾄﾅﾆﾇﾈﾉﾊﾋﾌﾍﾎﾏﾐﾑﾒﾓﾔﾕﾖﾗﾘﾙﾚﾛﾜｦﾝｧｨｩｪｫｬｭｮｯ､｡ｰ｢｣ﾞﾟ";

  KANA_ZEN = "" + "アイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモヤユヨラリルレロワヲンァィゥェォャュョッ、。ー「」" + "　　　　　ガギグゲゴザジズゼゾダヂヅデド　　　　　バビブベボ　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　" + "　　　　　　　　　　　　　　　　　　　　　　　　　パピプペポ　　　　　　　　　　　　　　　　　　　　　　　　　　　　　";

  toZenkakuKANAHIRA = function(str) {
    var ans, c, cnext, i, len, n, nnext, _i;
    ans = '';
    len = str.length;
    for (i = _i = 0; 0 <= len ? _i < len : _i > len; i = 0 <= len ? ++_i : --_i) {
      c = str.charAt(i);
      cnext = str.charAt(i + 1);
      n = KANA_HAN.indexOf(c);
      nnext = KANA_HAN.indexOf(cnext);
      if (n >= 0) {
        if (nnext === 60) {
          c = KANA_ZEN.charAt(n + 60);
          i++;
        } else if (nnext === 61) {
          c = KANA_ZEN.charAt(n + 120);
          i++;
        } else {
          c = KANA_ZEN.charAt(n);
        }
      }
      if ((n !== 60) && (n !== 61)) {
        ans += c;
      }
    }
    return ans;
  };

  HAN = ' 1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!"#$%&()=-|~\\[]{}<>,.?/_\'';

  ZEN = '　１２３４５６７８９０ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ！”＃＄％＆（）＝－｜～￥［］｛｝＜＞、．？／＿’';

  toZenkakuASCII = function(str) {
    var ans, c, p, _i, _len;
    ans = '';
    for (_i = 0, _len = str.length; _i < _len; _i++) {
      c = str[_i];
      p = HAN.indexOf(c);
      ans += p >= 0 ? ZEN.charAt(p) : c;
    }
    return ans;
  };

  TRANS_H = "-|→↑←↓｜ー−―‐｜｜｜｜";

  TRANS_V = "|-↓→↑←ー｜｜｜｜ー−―‐";

  toZenkaku = function(str) {
    return toZenkakuASCII(toZenkakuKANAHIRA(str));
  };

  text2lines = function(text) {
    return text.split("\n");
  };

  lines2text = function(lines) {
    return lines.join("\n");
  };

  reverseStr = function(str) {
    return str.split("").reverse().join("");
  };

  reverseLines = function(lines) {
    return lines.reverse();
  };

  reverseText = function(text) {
    return text.split("\n").reverse().join("\n");
  };

  H2V = (function() {
    function H2V() {}

    H2V.h2vText = function(text) {
      return H2V.h2vLines(text2lines(text)).join("\n");
    };

    H2V.h2vLines = function(lines) {
      var ans, c, i, idx, line, max_len, num_line, str, y, _i, _j, _k, _l, _len, _len1, _ref, _ref1;
      lines = reverseLines(lines);
      lines = (function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = lines.length; _i < _len; _i++) {
          line = lines[_i];
          _results.push(toZenkaku(line));
        }
        return _results;
      })();
      max_len = Math.max.apply(null, (function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = lines.length; _i < _len; _i++) {
          str = lines[_i];
          _results.push(str.length);
        }
        return _results;
      })());
      num_line = lines.length;
      for (idx = _i = 0, _len = lines.length; _i < _len; idx = ++_i) {
        line = lines[idx];
        for (i = _j = 0, _ref = max_len - line.length; 0 <= _ref ? _j < _ref : _j > _ref; i = 0 <= _ref ? ++_j : --_j) {
          lines[idx] += "　";
        }
      }
      ans = (function() {
        var _k, _results;
        _results = [];
        for (y = _k = 0; 0 <= max_len ? _k < max_len : _k > max_len; y = 0 <= max_len ? ++_k : --_k) {
          _results.push("");
        }
        return _results;
      })();
      for (i = _k = 0; 0 <= num_line ? _k < num_line : _k > num_line; i = 0 <= num_line ? ++_k : --_k) {
        _ref1 = lines[i];
        for (idx = _l = 0, _len1 = _ref1.length; _l < _len1; idx = ++_l) {
          c = _ref1[idx];
          ans[idx] += c;
        }
      }
      return ans;
    };

    H2V.v2hText = function(text) {
      return H2V.v2hLines(text2lines(text)).join("\n");
    };

    H2V.v2hLines = function(lines) {
      var idx, line, _i, _len;
      lines = H2V.h2vLines(lines);
      for (idx = _i = 0, _len = lines.length; _i < _len; idx = ++_i) {
        line = lines[idx];
        lines[idx] = reverseStr(line);
      }
      return lines.reverse();
    };

    H2V.transStr = function(str, fromStr, toStr) {
      var ans, c, p, _i, _len;
      ans = '';
      for (_i = 0, _len = str.length; _i < _len; _i++) {
        c = str[_i];
        p = fromStr.indexOf(c);
        ans += p >= 0 ? toStr.charAt(p) : c;
      }
      return ans;
    };

    H2V.transStrH2V = function(str, fromStr, toStr) {
      if (fromStr == null) {
        fromStr = TRANS_H;
      }
      if (toStr == null) {
        toStr = TRANS_V;
      }
      return H2V.transStr(str, fromStr, toStr);
    };

    H2V.transStrV2H = function(str, fromStr, toStr) {
      if (fromStr == null) {
        fromStr = TRANS_V;
      }
      if (toStr == null) {
        toStr = TRANS_H;
      }
      return H2V.transStr(str, fromStr, toStr);
    };

    H2V.get_tweetURL = function(content) {
      var encoded, url;
      encoded = encodeURIComponent(content);
      return url = "https://twitter.com/intent/tweet?text=" + encoded;
    };

    return H2V;

  })();

  if (typeof module !== "undefined" && module !== null ? module.exports : void 0) {
    module.exports = H2V;
  } else {
    this.H2V = H2V;
  }

}).call(this);
