assert = require 'assert'
{flip} = require 'ramda' #auto_require:ramda
{changedPaths, pickRec} = require 'ramda-extras'

lifters = require './lifters'

eq = flip assert.equal
deepEq = flip assert.deepStrictEqual
throws = (re, f) -> assert.throws f, re
fit = (spec, o) ->
	paths = changedPaths spec
	subO = pickRec paths, o
	deepEq spec, subO
yfit = flip fit


describe 'lifters', ->




