{} = require 'ramda' #auto_require:ramda
{ymerge} = require 'ramda-extras'
{Link} = require 'react-functional-router'

{BaseDemo} = require './BaseDemo'
uiUtils = require '../uiUtils'

DemoPage_ = ({comp}, _) ->
	_ {},
		_ 'h1', {}, 'Demo'
		_ {},
			_ Link, {$to: ymerge({comp:'Base'})}, 'Base'
			if comp == 'Base' then _ BaseDemo

		# _ 'h1', {}, 'Mocked data'
		# _ {},
		# 	_ 'a', {href: 'week?mock=week1'}, 'Week'

module.exports = uiUtils.createComps {DemoPage_}






