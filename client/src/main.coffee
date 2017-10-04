require 'event-source-polyfill'
require 'whatwg-fetch'

React = require 'react'
ReactDOM = require 'react-dom'
Pawpaw = require 'pawpaw'
{Phlox} = require 'phlox'
Oublie = require 'oublie'
{always, flip, forEach, isNil, keys, map, match, merge, test, without} = R = require 'ramda' #auto_require:ramda
{ymap, yevolve} = RE = require 'ramda-extras'
datefns = require 'date-fns'
fela = require 'fela'
firebase = require 'firebase'
{createRouter} = require 'react-functional-router'

viewModels = require './base/viewModels'
queriers = require './base/queriers'
invokers = require './base/invokers'
lifters = require './base/lifters'
createTree = require './base/parser'
require './normalize.css'
require './style.css'

App = React.createFactory require('./App')

firebase.initializeApp
	apiKey: 'AIzaSyBKxW9gqqFr8kIeAQSCpltvShvnq63Mrg8'
	authDomain: 'surf-rapport-51ff0.firebaseapp.com'
	databaseURL: 'https://surf-rapport-51ff0.firebaseio.com'
	projectId: 'surf-rapport-51ff0'
	storageBucket: 'surf-rapport-51ff0.appspot.com'
	messagingSenderId: '514215155141'

window.firebase = firebase


today = parseInt datefns.format(new Date(), 'YYYYMMDD')

initialData =
	ui:
		today: today
	query: {}

onQuery = (queryObj, key, isInvoker) ->
	if isInvoker
		parser.exec queryObj

	else
		if isNil queryObj
			parser.exec {Cache: 'sub', key, query: null}
			return
		{query, strategy, expiry} = queryObj
		parser.exec {Cache: 'sub', key, query, strategy, expiry}

onAction = (action, args, meta) ->
	parser.execIter action, args, meta

phlox = new Phlox {viewModels, queriers, invokers, parser, lifters, onQuery, onAction, initialData}
if DEV
	phlox._dev_stateChanged = (data) ->
		req =
			method: 'PUT'
			body: JSON.stringify data
			headers: new Headers({'Content-Type': 'application/json'}) 
			mode: 'cors'
			redirect: 'follow'

		fetch "http://localhost:3417/dev/data/state?shouldOverwrite=true", req

oublie = new Oublie
	pub: (key, delta) => parser.exec {Cache: 'pub', key, delta}
	remote: (key, query, meta) =>
		if meta && meta.stack
			parser.execManually {Cache: 'remote', key, query}, null, meta.stack
		else
			parser.exec {Cache: 'remote', key, query}
	debounceTime: 10

if DEV
	oublie._dev_dataChanged = (data) =>
		req =
			method: 'PUT'
			body: JSON.stringify data
			headers: new Headers({'Content-Type': 'application/json'}) 
			mode: 'cors'
			redirect: 'follow'

		fetch "http://localhost:3417/dev/data/cache?shouldOverwrite=true", req


router = null # ref that's assigned later
getRouter = -> router

parser = new Pawpaw createTree(phlox, oublie, firebase, getRouter)
parser.logLevel = 999

onRouterChange = (state, delta) -> parser.exec {RouteChange: delta}

router = createRouter {onChange: onRouterChange}

window.app = phlox

felaMountNode = document.getElementById('stylesheet')
felaRenderer = fela.createRenderer(felaMountNode)

# window.mock = ymap mock, (f) -> () -> app.reset f()
# window.mock.login1 = () -> app.change {ui: {userId: 1}}

# window.mock = mock(phlox)

nullifiedViewModels = map always(null), viewModels

# if test /mock=(.*)$/, window.location.search
# 	mockName = match(/mock=(.*)$/, window.location.search)[1]
# 	console.log {mockName}
# 	flip(setTimeout) 1000, ->
# 		mockedViewModels = mock.viewModels[mockName]
# 		phlox.mock {viewModels: merge(nullifiedViewModels, mockedViewModels)}



install = (o, target) ->
	addKey = (k) -> target[k] = o[k]
	forEach addKey, keys o
	
install {R}, window
install R, window

install {RE}, window
install RE, window

window.datefns = datefns

# http://stackoverflow.com/questions/41448596/shortcut-to-clear-console-in-chrome-dev-tools-without-having-dev-tools-focused/41448862#41448862
doc_keyUp = (e) ->
	if (e.ctrlKey && e.keyCode == 68) # 68 = d
		console.clear()
document.addEventListener 'keyup', doc_keyUp, false


onResize = () ->
	# theory: we just really need the width, height is not important
	# parser.exec {UI: {screen: {w: window.innerWidth, h: window.innerHeight}}}


ReactDOM.render(App({phlox, router, onResize, felaRenderer}), document.getElementById('root'))

if module.hot
	module.hot.accept ['./base/viewModels', './base/queriers', './base/lifters'], (updated) ->
		nextViewModels = require './base/viewModels'
		nextQueriers = require './base/queriers'
		nextLifters = require './base/lifters'
		phlox.reinitialize {viewModels: nextViewModels, queriers: nextQueriers, lifters: nextLifters}
