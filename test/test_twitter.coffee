
util = require 'util'
assert = require('chai').assert

path = require 'path'
libPath = if (process.env.TEST_COV) then 'lib-cov/h2v' else  'lib/h2v'
libPath = path.join __dirname, '..', libPath
H2V = require libPath

describe "get_tweetURL", ->
  it 'tweet "a"', ->
    assert.equal H2V.get_tweetURL('a'), 'https://twitter.com/intent/tweet?text=a'

  it 'tweet "あ"', ->
    assert.equal H2V.get_tweetURL('あ'), 'https://twitter.com/intent/tweet?text=%E3%81%82'

  it 'tweet "あ\\nい"', ->
    assert.equal H2V.get_tweetURL('あ\nい'), 'https://twitter.com/intent/tweet?text=%E3%81%82%0A%E3%81%84'
