
util = require 'util'
assert = require('chai').assert

path = require 'path'
libPath = if (process.env.TEST_COV) then 'lib-cov/h2v' else  'lib/h2v'
libPath = path.join __dirname, '..', libPath
H2V = require libPath

describe "transStrH2V", ->
  it 'transStrH2V "" ', ->
    assert.equal H2V.transStrH2V('→↑←↓'), '↓→↑←'
    assert.equal H2V.transStrV2H(H2V.transStrH2V('→↑←↓')), '→↑←↓'

    assert.equal H2V.transStrH2V('1-'),  '1|'      # -
    assert.equal H2V.transStrH2V('2|'),  '2-'
    assert.equal H2V.transStrH2V('3｜'), '3ー'    # 長音 ー

    assert.equal H2V.transStrH2V('4ー'), '4｜'    # 長音 ー
    assert.equal H2V.transStrH2V('5−'), '5｜'     # ハイフン マイナス −
    assert.equal H2V.transStrH2V('6―'), '6｜'     # ダッシュ ―
    assert.equal H2V.transStrH2V('7‐'), '7｜'     # ハイフン ‐


describe "transStrV2H", ->
  it 'transStrV2H ""', ->
    assert.equal H2V.transStrV2H('→↑←↓'), '↑←↓→'
    assert.equal H2V.transStrH2V(H2V.transStrV2H('→↑←↓')), '→↑←↓'

    assert.equal H2V.transStrV2H('1-'),  '1|'      # -
    assert.equal H2V.transStrV2H('2|'),  '2-'
    assert.equal H2V.transStrV2H('3｜'), '3ー'     # 長音 ー
    assert.equal H2V.transStrV2H('4ー'), '4｜'     # 長音 ー
    assert.equal H2V.transStrV2H('5−'), '5｜'      # ハイフン マイナス −
    assert.equal H2V.transStrV2H('6―'), '6｜'      # ダッシュ ―
    assert.equal H2V.transStrV2H('7‐'), '7｜'      # ハイフン ‐

