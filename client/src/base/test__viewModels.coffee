assert = require 'assert'
{flip, isNil} = require 'ramda' #auto_require:ramda
{ychange, fits, diff, ydiff, changedPaths, pickRec} = require 'ramda-extras'

vms = require './viewModels'

eq = flip assert.strictEqual
deepEq = flip assert.deepStrictEqual
yeq = assert.equal
ydeepEq = assert.deepStrictEqual
throws = (f) -> assert.throws f, Error
fit = (spec, o) ->
	paths = changedPaths spec
	if isNil o then throw new Error 'o is ' + o
	subO = pickRec paths, o
	deepEq spec, subO
yfit = flip fit


describe 'viewModels', ->
	
