{isNil} = require 'ramda' #auto_require:ramda

{DemoPage_} = require './demo/DemoPage'
uiUtils = require './uiUtils'



Body_ = ({page}, _) ->
	_ {wp: 100},
			if page == 'demo' then _ DemoPage_
			# else if isNil(page) then _ FeedPage_
			else
				_ {}, '404 - Du gick på grund, byt till kortare fena och försök igen'

module.exports = uiUtils.createComps {Body_}


