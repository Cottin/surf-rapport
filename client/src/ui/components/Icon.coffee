{isNil, merge, none, path, prop, set} = require 'ramda' #auto_require:ramda
{createElement: _, DOM: {div, h2, svg, path}} = React = require 'react' #auto_require:react
createReactClass = require 'create-react-class'
{number, string} = require 'prop-types'

Settings = createReactClass
	render: ->
		svg merge(@props, {xmlns: 'http://www.w3.org/2000/svg', viewBox: '0 0 24 24'}),
			path {d: 'M0 0h24v24H0z', fill: 'none'}
			path {d: 'M19.43 12.98c.04-.32.07-.64.07-.98s-.03-.66-.07-.98l2.11-1.65c.19-.15.24-.42.12-.64l-2-3.46c-.12-.22-.39-.3-.61-.22l-2.49 1c-.52-.4-1.08-.73-1.69-.98l-.38-2.65C14.46 2.18 14.25 2 14 2h-4c-.25 0-.46.18-.49.42l-.38 2.65c-.61.25-1.17.59-1.69.98l-2.49-1c-.23-.09-.49 0-.61.22l-2 3.46c-.13.22-.07.49.12.64l2.11 1.65c-.04.32-.07.65-.07.98s.03.66.07.98l-2.11 1.65c-.19.15-.24.42-.12.64l2 3.46c.12.22.39.3.61.22l2.49-1c.52.4 1.08.73 1.69.98l.38 2.65c.03.24.24.42.49.42h4c.25 0 .46-.18.49-.42l.38-2.65c.61-.25 1.17-.59 1.69-.98l2.49 1c.23.09.49 0 .61-.22l2-3.46c.12-.22.07-.49-.12-.64l-2.11-1.65zM12 15.5c-1.93 0-3.5-1.57-3.5-3.5s1.57-3.5 3.5-3.5 3.5 1.57 3.5 3.5-1.57 3.5-3.5 3.5z'}

ArrowLeft = createReactClass
	render: ->
		svg merge(@props, {xmlns: 'http://www.w3.org/2000/svg', viewBox: '0 0 24 24'}),
	    path {d: 'M15.41 16.09l-4.58-4.59 4.58-4.59L14 5.5l-6 6 6 6z'}
	    path {d: 'M0-.5h24v24H0z', fill: 'none'}

icons =
	settings: Settings
	arrow_left: ArrowLeft

Icon = createReactClass
	displayName: 'Icon'

	propTypes:
		fill: string
		# set width & height using STYLE prop

	getDefaultProps: ->
		name: 'settings'
		fill: 'rgba(0,0,0,0.26)'

	render: ->
		style = {}

		{name, fill} = @props
		icon = icons[name]
		if isNil icon then throw new Error "Icon Error: no icon named #{icon}"

		div {style: merge(style, @props.style)},
			_ icon, {fill}

module.exports = Icon
