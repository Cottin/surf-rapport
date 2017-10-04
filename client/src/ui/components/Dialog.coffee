{createElement: _, DOM: {div}} = React = require 'react' #auto_require:react
createReactClass = require 'create-react-class'
{bool, func} = require 'prop-types'
{isNil} = require 'ramda' #auto_require:ramda

Portal = require './Portal'
{pf} = require '../uiUtils'

Dialog = createReactClass
	displayName: 'Dialog'

	propTypes:
		isOpen: bool
		onRequestClose: func

	# getInitialState: ->
	# 	if isNil @props.isOpen
	# 		{isOpen: false}
	# 	else
	# 		{}

	renderLayer: ->
		style = 
			position: 'fixed'
			zIndex: '99999'
			top: 0
			left: 0
			justifyContent: 'center'
			alignItems: 'center'
			width: '100%'
			height: '100%'
			background: 'rgba(0,0,0,0.32)'

		div {is: 'layer_of_Dialog', style, onClick: @onClickAway},
			div {is: 'wrapper_of_children', onClick: (e) -> e.stopPropagation()},
				@props.children

	render: ->
		# if isNil(@props.isOpen)
		# 	if !@state.isOpen then return null
		# else
		# 	if !@props.isOpen then return null

		if !@props.isOpen then return null
		_ Portal, {renderFn: @renderLayer}

	onClickAway: (e) ->
		@props.onRequestClose?('click_away', e)


module.exports = Dialog
