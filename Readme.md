
これは tweeter で縦書きで投稿するためのツールです。

travis: [![Build Status](https://travis-ci.org/katoy/yoko2tate.png?branch=master)](https://travis-ci.org/katoy/yoko2tate)

インストール
============

    $ git clone https://github.com/katoy/yoko2tate.git
	$ npm install

動作チェック
=============

    $ npm test
	
	public/index.html を web-browser でオープンします。


デモサイト：　http://homepage2.nifty.com/youichi_kato/src/h2v/pub/index.html

使い方：
======
2つのテキストエリアがあります。
左側が横書き用、右側が縦書き用です。
どちらかのテキストエリアを編集すると、他方のテキストエリアに逐次 変換結果が反映されます。
お試し用文書 の一部を 縦書き用のテキストエリアに　cut & past してみたください。

［Tweet...］ボタンをクリックすると、縦書き用テキストエリアの内容を twitter に投稿できます。

参考サイト
==========
次のサイトを参考にして作成しました。
　http://www.openspc2.org/reibun/javascript/business/003/
　> 半角カナから全角カナへ変換する（濁点等対応版）
 
　http://yubais.net/tatetwi/
　> 縦書きツイート作成ツール

TODO:
 phantomjs, chrome を使って testling でのブラウザ操作のテストを行う事。
 
