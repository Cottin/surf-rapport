{none} = require 'ramda' #auto_require:ramda
{cc} = require 'ramda-extras'

_ERR = 'Beach-shorty-attr: '

src = (x) ->
	switch x
		when 'sun-ppl' then {src: "#{PUBLIC_BASE}img/sun_people.png"}
		else throw new Error _ERR + "invalid src '#{x}'"

#auto_export:none_
module.exports = {src}