
util = require 'util'
assert = require('chai').assert

path = require 'path'
libPath = if (process.env.TEST_COV) then 'lib-cov/h2v' else  'lib/h2v'
libPath = path.join __dirname, '..', libPath
H2V = require libPath

describe "h2vText", ->
  it 'h2vText("ABC D") ->"Ａ\\nＢ\\nＣ\\n\　\\nＤ"', ->
    assert.equal H2V.h2vText('ABC D'), "Ａ\nＢ\nＣ\n　\nＤ"
    assert.equal H2V.v2hText(H2V.h2vText('ABC D')), "ＡＢＣ　Ｄ"

  it 'h2vText("あいう") ->"あ\\nい\\nう"', ->
    assert.equal H2V.h2vText('あいう'), "あ\nい\nう"
    assert.equal H2V.v2hText(H2V.h2vText('あいう')), "あいう"

  it 'h2vText("がぎぐ") ->"が\\nぎ\\nぐ"', ->
    assert.equal H2V.h2vText('がぎぐ'), "が\nぎ\nぐ"
    assert.equal H2V.v2hText(H2V.h2vText('がぎぐ')), "がぎぐ"

  it 'h2vText("ぱぴぷ") ->"ぱ\\nぴ\\nぶ"', ->
    assert.equal H2V.h2vText('ぱぴぷ'), "ぱ\nぴ\nぷ"
    assert.equal H2V.v2hText(H2V.h2vText('ぱぴぷ')), "ぱぴぷ"

  it 'h2vText("ｱｲｳ") ->"ア\\nイ\\nウ"', ->
    assert.equal H2V.h2vText('ｱｲｳ'), "ア\nイ\nウ"
    assert.equal H2V.v2hText(H2V.h2vText('ｱｲｳ')), "アイウ"

  it 'h2vText("ｶﾞｷﾞｸﾞ") ->"ガ\\nギ\\nグ"', ->
    assert.equal H2V.h2vText('ｶﾞｷﾞｸﾞ'), "ガ\nギ\nグ"
    assert.equal H2V.v2hText(H2V.h2vText('ｶﾞｷﾞｸﾞ')), "ガギグ"

  it 'h2vText("ﾊﾟﾋﾟﾌﾟ") ->"パ\\nピ\\nプ"', ->
    assert.equal H2V.h2vText('ﾊﾟﾋﾟﾌﾟ'), "パ\nピ\nプ"
    assert.equal H2V.v2hText(H2V.h2vText('ﾊﾟﾋﾟﾌﾟ')), "パピプ"

  it 'h2vText("123\\nABC\\XYZ") ->"XA1\\nYB2\\nZC3"', ->
    assert.equal H2V.h2vText('123\nABC\nXYZ'), "ＸＡ１\nＹＢ２\nＺＣ３"
    assert.equal H2V.v2hText(H2V.h2vText('123\nABC\nXYZ')), "１２３\nＡＢＣ\nＸＹＺ"

  it 'h2vText(矢印記号)', ->
    assert.equal H2V.h2vText('ー→↑←↓－ー｜│'), "ー\n→\n↑\n←\n↓\n－\nー\n｜\n│"
    assert.equal H2V.v2hText(H2V.h2vText('ー→↑←↓－ー｜│')), "ー→↑←↓－ー｜│"

  it 'h2vText("a\\nbc")', ->
    assert.equal H2V.h2vText("a\nbc"), "ｂａ\nｃ　"


