{ymerge} = require 'ramda-extras'
{} = require 'ramda' #auto_require:ramda
# {Link} = require 'react-functional-router'

{createComps} = require '../uiUtils'


BaseDemo = ({}, _) ->
	_ {p: '2vw'},
		_ {},
			_ 'h2', {}, 'Text'
			_ {x: 'r'},
				_ {x: 'c', p: '1vw'},
					_ {f: 105000}, '0 - Patua One'
					_ {f: 115000}, '1 - Patua One'
					_ {f: 125000}, '2 - Patua One'
					_ {f: 135000}, '3 - Patua One'
					_ {f: 145000}, '4 - Patua One'
					_ {f: 155000}, '5 - Patua One'
					_ {f: 165000}, '6 - Patua One'
					_ {f: 175000}, '7 - Patua One'
					_ {f: 185000}, '8 - Patua One'
					_ {f: 195000}, '9 - Patua One'
				_ {x: 'c', p: '1vw'},
					_ {f: 201040}, '0 - Helvetica'
					_ {f: 211040}, '1 - Helvetica'
					_ {f: 221040}, '2 - Helvetica'
					_ {f: 231040}, '3 - Helvetica'
					_ {f: 241040}, '4 - Helvetica'
					_ {f: 251040}, '5 - Helvetica'
					_ {f: 261040}, '6 - Helvetica'
					_ {f: 271040}, '7 - Helvetica'
					_ {f: 281040}, '8 - Helvetica'
					_ {f: 291040}, '9 - Helvetica'
				_ {x: 'c', p: '1vw'},
					_ {f: 306000}, '0 - Delius'
					_ {f: 316000}, '1 - Delius'
					_ {f: 326000}, '2 - Delius'
					_ {f: 336000}, '3 - Delius'
					_ {f: 346000}, '4 - Delius'
					_ {f: 356000}, '5 - Delius'
					_ {f: 366000}, '6 - Delius'
					_ {f: 376000}, '7 - Delius'
					_ {f: 386000}, '8 - Delius'
					_ {f: 396000}, '9 - Delius'
		_ {},
			_ 'h2', {}, 'BG'
			_ {x: 'r__w'},
				_ {m: '1vw'}, 
					_ {bg: 'green', w: 50, h: 40}
					_ {}, 'green'
				_ {m: '1vw'}, 
					_ {bg: 'blue', w: 50, h: 40}
					_ {}, 'blue'
				_ {m: '1vw'}, 
					_ {bg: 'orange', w: 50, h: 40}
					_ {}, 'orange'
				_ {m: '1vw'}, 
					_ {bg: 'yellow', w: 50, h: 40}
					_ {}, 'yellow'
				_ {m: '1vw'}, 
					_ {bg: 'red', w: 50, h: 40}
					_ {}, 'red'
				_ {m: '1vw'}, 
					_ {bg: 'grey', w: 50, h: 40}
					_ {}, 'grey'
				_ {m: '1vw'}, 
					_ {bg: 'purple', w: 50, h: 40}
					_ {}, 'purple'
				_ {m: '1vw'}, 
					_ {bg: 'dark', w: 50, h: 40}
					_ {}, 'dark'


module.exports = createComps {BaseDemo}






