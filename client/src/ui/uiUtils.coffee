{merge, none, prop, props, test, type} = require 'ramda' #auto_require:ramda
{ymapObjIndexed} = require 'ramda-extras'
React = require 'react'
{object} = require 'prop-types'
shortstyle = require 'shortstyle'
createReactClass = require 'create-react-class'
PureRenderMixin = require 'react-addons-pure-render-mixin'
{connect} = require 'phlox'

styleMaps = require './styleMaps'
attrMaps = require './attrMaps'

_calculateProps = shortstyle styleMaps, attrMaps

# Runs supplied props through shortstyle and runs the result through fela and
# lastly calls React.createElement
_createElementFela = (renderer) -> ->
	[a0]  = arguments

	if type(a0) == 'String'
		_createElementString.apply renderer, arguments
	else if type(a0) == 'Object'
		_createElementDiv.apply renderer, arguments
	else
		_createElementComponent.apply renderer, arguments


_createElementString = (s, props, children...) ->
	[props_, style] = _calculateProps(props)
	className = @renderRule (-> style), {}
	React.createElement s, merge(props_, {className}), children...

_createElementDiv = (props, children...) ->
	[props_, style] = _calculateProps(props)
	className = @renderRule (-> style), {}
	React.createElement 'div', merge(props_, {className}), children...
	# React.createElement 'div', merge(props_, {style}), children...

_createElementComponent = (component, props, children...) ->
	[props_, style] = _calculateProps(props)
	className = @renderRule (-> style), {}
	React.createElement component, merge(props_, {className}), children...


createComp = (f, name) ->
	createReactClass
		displayName: name
		mixins: [PureRenderMixin]
		contextTypes:
			renderer: object
			router: object
		render: ->
			createElement = _createElementFela(@context.renderer)
			navigate = (f) => @context.router.navigate @context.router.buildUrl f
			f @props, createElement, {navigate}

createComps = (o) ->
	ymapObjIndexed o, (f, k) ->
		comp = createComp f, k
		if test /_$/, k then connect comp, k
		else comp

#auto_export:none_
module.exports = {createComp, createComps}