{} = require 'ramda' #auto_require:ramda
{} = require 'ramda-extras'
df = require 'date-fns'

	
Body_ = ({page}, {}) -> {page}
	
DemoPage_ = ({query: {comp}}, {}) -> {comp}


#auto_export:phlox
module.exports = {
	Body_: {dataDeps: ['page'], stateDeps: [], f: Body_},
	DemoPage_: {dataDeps: ['query.comp'], stateDeps: [], f: DemoPage_}
}