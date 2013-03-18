
util = require 'util'
assert = require('chai').assert

path = require 'path'
libPath = if (process.env.TEST_COV) then 'lib-cov/h2v' else  'lib/h2v'
libPath = path.join __dirname, '..', libPath
H2V = require libPath

describe "v2hText", ->
  it 'v2hText("ABC D") ->"Ｄ\\n　\\nＣ\\nＢ\\nＡ"', ->
    assert.equal H2V.v2hText('ABC D'), "Ｄ\n　\nＣ\nＢ\nＡ"
    assert.equal H2V.h2vText(H2V.v2hText('ABC D')), "ＡＢＣ　Ｄ"

  it 'v2hText("あいう") ->"う\\nい\\nあ"', ->
    assert.equal H2V.v2hText('あいう'), "う\nい\nあ"
    assert.equal H2V.h2vText(H2V.v2hText('あいう')), "あいう"

  it 'v2hText("がぎぐ") ->"ぐ\\nぎ\\nが"', ->
    assert.equal H2V.v2hText('がぎぐ'), "ぐ\nぎ\nが"
    assert.equal H2V.h2vText(H2V.v2hText('がぎぐ')), "がぎぐ"

  it 'v2hText("ぱぴぷ") ->""ぷ\\nぴ\\nぱ', ->
    assert.equal H2V.v2hText('ぱぴぷ'), "ぷ\nぴ\nぱ"
    assert.equal H2V.h2vText(H2V.v2hText('ぱぴぷ')), "ぱぴぷ"

  it 'v2hText("ｱｲｳ") ->"ウ\\nイ\\nア"', ->
    assert.equal H2V.v2hText('ｱｲｳ'), "ウ\nイ\nア"
    assert.equal H2V.h2vText(H2V.v2hText('ｱｲｳ')), "アイウ"

  it 'v2hText("ｶﾞｷﾞｸﾞ") ->"グ\\nギ\\nガ"', ->
    assert.equal H2V.v2hText('ｶﾞｷﾞｸﾞ'), "グ\nギ\nガ"
    assert.equal H2V.h2vText(H2V.v2hText('ｶﾞｷﾞｸﾞ')), "ガギグ"

  it 'v2hText("ﾊﾟﾋﾟﾌﾟ") ->"プ\\nピ\\nパ"', ->
    assert.equal H2V.v2hText('ﾊﾟﾋﾟﾌﾟ'), "プ\nピ\nパ"
    assert.equal H2V.h2vText(H2V.v2hText('ﾊﾟﾋﾟﾌﾟ')), "パピプ"

  it 'v2hText("123\\nABC\\XYZ") ->"３ＣＺ\\n２ＢＹ\n１ＡＸ"', ->
    assert.equal H2V.v2hText('123\nABC\nXYZ'), "３ＣＺ\n２ＢＹ\n１ＡＸ"
    assert.equal H2V.h2vText(H2V.v2hText('123\nABC\nXYZ')), "１２３\nＡＢＣ\nＸＹＺ"

  it 'v2hText(矢印記号)', ->
    assert.equal H2V.v2hText('ー→↑←↓－ー｜│'), "│\n｜\nー\n－\n↓\n←\n↑\n→\nー"
    assert.equal H2V.h2vText(H2V.v2hText('ー→↑←↓－ー｜│')), "ー→↑←↓－ー｜│"