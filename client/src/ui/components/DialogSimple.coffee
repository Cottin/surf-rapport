{createElement: _, DOM: {div}} = React = require 'react' #auto_require:react
createReactClass = require 'create-react-class'
{bool, func} = require 'prop-types'
{} = require 'ramda' #auto_require:ramda

Dialog = require './Dialog'
{pf} = require '../uiUtils'

DialogSimple = createReactClass
	displayName: 'DialogSimple'

	propTypes:
		isOpen: bool
		onRequestClose: func

		renderTitle: func


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
			@props.children

	render: ->
		{isOpen, onClickAway, onRequestClose} = @props
		_ Dialog, {isOpen, onRequestClose}, @renderContent()

	renderContent: ->
		box = pf
			background: 'rgba(255, 255, 255, 0.92)'
			boxShadow: '1px 2px 2px 1px rgba(0,0,0,0.12)'
			width: '80vw'
			maxWidth: 400

		top = pf
			height: 60
			borderBottom: '1px solid rgba(219, 219, 219, 0.5)'
			flexDirection: 'row'
			justifyContent: 'center'
			alignItems: 'center'

		body = pf
			flexDirection: 'row'
			justifyContent: 'center'
			padding: 20

		bottom = pf
			height: 60
			borderTop: '1px solid rgba(219, 219, 219, 0.5)'
			fontFamily: 'Roboto'
			fontSize: 12
			color: '#777777'
			fontWeight: 300
			flexDirection: 'row'
			justifyContent: 'center'
			alignItems: 'center'

		div {style: box},
			div {style: top}, @props.renderTitle()
			div {style: body}, @props.children
			div
				style: bottom
				onClick: (e) =>
					@props.onRequestClose?('close_button', e)
					e.stopPropagation()
			, 'CLOSE'




module.exports = DialogSimple
