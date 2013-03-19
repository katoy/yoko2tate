# Refer:
# 1. https://github.com/twilson63/cakefile-template/blob/master/Cakefile
# 2. https://github.com/jashkenas/docco/blob/master/Cakefile

# Requirements

fs = require 'fs-extra'
path = require 'path'
util = require 'util'
{spawn, exec} = require 'child_process'

bin_path = './node_modules/.bin'
stream_data_handler = (data) ->
  util.print "#{data.toString()}"

# Helper Functions
puts = (data) ->
  _output data, bright

error = (data) ->
  _output data, red, 'ERR'

success = (data) ->
  _output data, green, 'OK'

fail = (data) ->
  _output data, red, 'FAIL'

pass = (data) ->
  _output data, green, 'PASS'

_output = (data, color, prefix) ->
  data = data.toString().trim() unless typeof data is 'string'
  util.print color
  if prefix?
    util.print "#{prefix}: "
    util.print bright
  util.puts data
  util.print reset

_cleanFiles = () ->

# ------------------
# Paths
files = [
  'lib',
  'bin',
  'docs',
  'src'
]

jsInput = 'src'
jsOutput = 'lib'
docOutput = 'docs'

for f in files
  isExt = fs.exists f
  unless isExt
    fs.mkdirpSync f

# ANSI Terminal Colors
bright = '\x1b[0;1m'
green = '\x1b[0;1;32m'
reset = '\x1b[0m'
red = '\x1b[0;1;31m'

try
  which = require('which').sync
catch err
  if process.platform.match(/^win/)?
    error 'the `which` module is required for windows\ntry: npm install which'
  which = null

# Arguments
option '-w', '--watch', 'continually build'
option '-f', '--force', 'clean all files in output folder whatever they\'re compilation outputs or anything else'
option '-r', '--rebuild', 'do relative cleaning tasks before build js or generate documents'

# Tasks
task 'build', 'build coffee scripts into js', (options) -> build(options)
task 'lint', 'lint coffee scripts', (options) -> lint(options)
task 'doc', 'generate documents', (options) -> doc(options)
task 'clean:all', 'clean pervious built js files and documents', (options) -> clean 'all', options.force
task 'clean:js', 'clean pervious built js files', (options) -> clean 'js', options.force
task 'clean:doc', 'clean pervious built documents', (options) -> clean 'doc', options.force
task 'test', 'do test', (options) -> test(options)
#task 'test2_node', 'do test2_node', (options) -> test2_node(options)
#task 'test2_node_tap', 'do test2_node_tap', (options) -> test2_node_tap(options)
#task 'test2_phantomjs', 'do test2_phantomjs', (options) -> test2_phantomjs(options)
task 'coverage', 'do coverage', (options) -> coverage(options)
task 'open_coverage', 'open coverage report', (options) -> open_coverage(options)

# Task Functions
build = (options, callback) ->
  clean 'js' if options.rebuild
  try
    coffeePath = which 'coffee'
  catch e
    error 'cannot find executable `coffee`'
    error 'check which coffee'
    return
  coffee = spawn coffeePath, ['-c' + (if options.watch then 'w' else ''), '-o', jsOutput, jsInput]
  coffee.stdout.on 'data', (data) -> puts data
  coffee.stderr.on 'data', (data) -> error data
  coffee.on 'exit', (status) ->
    callback?(status)
    exec "rm public/javascript/h2v.js", (err, stdout, stderr)  ->
      console.log(err) if err
      exec "cp #{jsOutput}/h2v.js public/javascript", (err, stdout, stderr)  ->
        console.log(err) if err
        if callback
          callback(err)
        else
          success "finished status=#{err}"

lint = (options, callback) ->
  try
    coffeePath = which 'coffee'
  catch e
    error 'cannot find executable `coffee`'
    error 'check which coffee'
    return
  coffee = spawn coffeePath, ['-l', jsInput]
  coffee.stdout.on 'data', (data) -> puts data
  coffee.stderr.on 'data', (data) -> error data
  coffee.on 'close', ->
    if callback != undefined
      callback(status)
    else
      success 'finished'

doc = (options, callback) ->
  clean 'doc' if options.rebuild
  try
    doccoPath = which 'docco'
  catch e
    error 'cannot fild executable `docco`'
    error 'check which docco'
    return
  test = path.normalize(jsInput.concat('/*.coffee'))
  puts test
  docco = spawn doccoPath, ['-o', docOutput, test]
  docco.stdout.on 'data', (data) -> puts data
  docco.stderr.on 'data', (data) -> error data
  docco.on 'close', ->
    fs.unlink '-p'
    if callback != undefined
      callback(status)
    else
      success 'building finished'

clean = (target = 'all', isForce = false) ->
  if isForce
    if target is 'js' or 'all'
      fs.rimraf.sync jsOutput
      fs.mkdir jsOutput
    if target is 'doc' or 'all'
      fs.rimraf.sync docOutput
      fs.mkdir docOutput
    success 'OK, now anything in output folder has gone...'
  else
    fs.readdir jsInput, (e, files) ->
      if e?
        error e
        return
      else
        for f in files
          continue unless path.extname(f) is '.coffee'
          if target is 'js' or 'all'
            jp = path.join jsOutput, f.substring(0, path.basename(f).length - path.extname(f).length) + '.js'
            fs.exists jp, (isExt) ->
              puts "Deleting #{jp}"
              if isExt then fs.unlink jp
          if target is 'doc' or 'all'
            dp = path.join docOutput, f.substring(0, path.basename(f).length - path.extname(f).length) + '.html'
            fs.exists dp, (isExt) ->
              puts "Deleting #{dp}"
              if isExt then fs.unlink dp

test = (options, callback) ->
  try
    mochaPath = which 'mocha'
  catch e
    error 'cannot find executable `mocha`'
    error 'check which coffee'
    return
  mocha = spawn mochaPath, ["--compilers", "coffee:coffee-script", "--reporter", "tap", "--timeout", "50000"]
  mocha.stdout.on 'data', (data) -> puts data
  mocha.stderr.on 'data', (data) -> error data
  mocha.on 'close', ->
    if callback != undefined
      callback(status)
    else
      success 'finished'

#test2_node = (otpions, callback) ->
#  try
#    nodePath = which 'node'
#  catch e
#    error 'cannot find executable `mocha`'
#    error 'check which coffee'
#    return
#  node = spawn nodePath, ["test2/node-index.js"]
#  node.stdout.on 'data', (data) -> puts data
#  node.stderr.on 'data', (data) -> error data
#  node.on 'close', ->
#    if callback != undefined
#      callback(status)
#    else
#      success 'finished'

#test2_node_tap = (otpions, callback) ->
#  try
#    nodePath = which 'node'
#  catch e
#    error 'cannot find executable `mocha`'
#    error 'check which coffee'
#    return
#  node = spawn nodePath, ["test2/node-tap-index.js"]
#  node.stdout.on 'data', (data) -> puts data
#  node.stderr.on 'data', (data) -> error data
#  node.on 'close', ->
#    if callback != undefined
#      callback(status)
#    else
#      success 'finished'

#test2_phantomjs = (otpions, callback) ->
#  puts "----- This task is under construction ..." 
#  try
#    phantomjsPath = which 'node'
#  catch e
#    error 'cannot find executable `mocha`'
#    error 'check which coffee'
#    return
#  ph = spawn phantomjsPath, ["test2/phantomjs-index.js"]
#  ph.stdout.on 'data', (data) -> puts data
#  ph.stderr.on 'data', (data) -> error data
#  ph.on 'close', ->
#    if callback != undefined
#      callback(status)
#    else
#      success 'finished'

remove_coverage = (callback) ->
  exec "rm -fr ./lib-cov"
  callback?()

make_coverage = (callback) ->
  options = [
    './lib'
    './lib-cov'
  ]
  jscoverage = spawn "#{bin_path}/jscoverage", options
  jscoverage.stdout.on 'data', stream_data_handler
  jscoverage.stderr.on 'data', stream_data_handler
  jscoverage.on 'exit', (status) -> callback?() if status is 0

run_coverage = (callback) ->
  process.env['TEST_COV'] = 1
  options = [
    '--reporter',
    'html-cov'
  ]
  mocha = spawn "#{bin_path}/mocha", options

  fileStream = fs.createWriteStream 'coverage.html'
  output = ''
  data_handler = (data) ->
    output =+ data if data
    fileStream.write data
  mocha.stdout.on 'data', data_handler
  mocha.stderr.on 'data', data_handler
  mocha.on 'exit', (status) -> callback?() if status is 0

coverage = (options) ->
  # puts "Do following."
  # puts '  $ rm -fr lib-cov'
  # puts '  $ jscoverage lib lib-cov'
  # puts '  $ TEST_COV=1 mocha --reporter html-cov > coverage.html'
  # puts ''
  build {}, ->
    remove_coverage ->
      make_coverage ->
        run_coverage ->
          success 'finished. See ./coverage.html. (cake open_coverage)'

open_coverage = (callback) ->
  exec 'open coverage.html'
  callback?()

