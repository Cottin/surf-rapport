{F, none, test} = require 'ramda' #auto_require:ramda
{cc} = require 'ramda-extras'

_ERR = 'SurfRapport: '

##### Probably things you'd want to override in your application:
##### Implementations below are provided as inspiration / templates

# font = "text"
f = (x) ->
	x_ = x + ''
	if ! test /^\d{6}$/, x_
		throw new Error "t expects a 6-digit number, given: #{x}, see docs"

	ret = {}

	family = x_[0]
	if family == '1' then ret.fontFamily = 'Finger Paint, cursiv'
	else if family == '2' then ret.fontFamily = 'Roboto, sans-serif'
	else if family == '3' then ret.fontFamily = 'Patua One, cursive'
	else throw new Error _ERR + "invalid family '#{family}' for t: #{x}"

	size = parseInt x_[1]
	switch size
		when 0 then ret.fontSize = '0.8rem'
		when 1 then ret.fontSize = '1rem'
		when 2 then ret.fontSize = '1.1rem'
		when 3 then ret.fontSize = '1.2rem'
		when 4 then ret.fontSize = '1.3rem'
		when 5 then ret.fontSize = '1.4rem'
		when 6 then ret.fontSize = '1.5rem'
		when 7 then ret.fontSize = '1.6rem'
		when 8 then ret.fontSize = '1.7rem'
		when 9 then ret.fontSize = '1.8rem'
		else throw new Error _ERR + "invalid size '#{size}' for t: #{x}"

	color = parseInt x_[2]
	opa = parseInt(x_[3])
	opacity = if opa == 0 then 1 else opa / 10
	switch color
		when 1 then ret.color = "rgba(130, 74, 23, #{opacity})"
		when 2 then ret.color = "rgba(186, 97, 0, #{opacity})"
		when 3 then ret.color = "rgba(187, 43, 0, #{opacity})"
		when 4 then ret.color = "rgba(255, 255, 255, #{opacity})"
		when 5 then ret.color = "rgba(102, 107, 111, #{opacity})"
		# when 6 then ret.color = "rgba(196, 138, 0, #{opacity})"
		when 6 then ret.color = "rgba(218, 144, 0, #{opacity})"
		when 7 then ret.color = "rgba(255, 249, 220, #{opacity})"
		else throw new Error _ERR + "invalid color '#{color}' for t: #{x}"

	ret.fontWeight = parseInt(x_[4]) * 100

	shadow = parseInt x_[5]
	switch shadow
		when 0 then # noop
		when 1 then ret.textShadow = '1px 1px 1px rgba(90,90,90,0.50)'
		when 2 then ret.textShadow = '1px 2px 0px #893C00'

	return ret

bg = (x) ->
	switch x
		when 'green' then {backgroundColor: '#BBE8C7'}
		when 'blue' then {backgroundColor: '#69D8C8'}
		when 'orange' then {backgroundColor: '#FAC98C'}
		when 'yellow' then {backgroundColor: '#F1F0B3'}
		when 'red' then {backgroundColor: '#E58886'}
		when 'grey' then {backgroundColor: 'rgba(0,0,0,0.42)'}
		when 'purple' then {backgroundColor: 'rgba(186,72,205,0.42)'}
		when 'dark' then {backgroundColor: '#202234'}

		# dev
		when 'lime' then backgroundColor: 'lime'
		when 'teal' then backgroundColor: 'teal'
		when 'pink' then backgroundColor: 'pink'
		when undefined then {}
		else throw new Error _ERR + "invalid background '#{x}'"




#auto_export:none_
module.exports = {f, bg}