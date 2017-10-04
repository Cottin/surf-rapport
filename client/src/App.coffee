{DOM: {div}, createElement: _} = React = require 'react'
createReactClass = require 'create-react-class'
{PhloxProvider} = require 'phlox'
{RouterProvider} = require 'react-functional-router'
{Provider: FelaProvider} = require 'react-fela'

{Body_} = require './ui/Body'


App = createReactClass
	componentWillMount: ->
		window.onresize = @props.onResize
		@props.onResize()

	componentWillUnmount: ->
		window.onresize = null

	render: ->
		{phlox, router, felaRenderer, felaMountNode} = @props
		div {},
			_ RouterProvider, {router},
				_ PhloxProvider, {phlox},
					_ FelaProvider, {renderer: felaRenderer},
						div {className: 'app__root'},
							_ Body_

module.exports = App


