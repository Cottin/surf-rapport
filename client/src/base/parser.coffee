popsiql = require 'popsiql'

sify = (o) -> JSON.stringify o, null, 2

pwrap = (promise, meta) ->
	promise.meta = meta
	return promise

createTree = (app, cache, firebase, getRouter) ->

	Write: -> (delta) -> app.change delta
	UI: -> (delta) -> app.change {ui: delta}

	RouteChange: -> (delta) -> app.change delta

	Router:
		navigate: ({f, page})-> 
			router = getRouter()
			router.navigate router.buildUrl f, page

		navigateHard: ({f, page})-> 
			router = getRouter()
			window.location = router.buildUrl f, page

	Cache:
		# reactions FROM the cache
		pub: ({key, delta}) ->
			yield {Write: {"#{key}": delta}}
		remote: ({key, query}) =>
			{method, url, body} = popsiql.toRest query
			val = yield {Api: {method, url, body}}

			# we need som pre-proccessing for one queries before feeding the cache
			if popsiql.getOp(query) == 'one'
				if isNil(val) || isEmpty(val) then return val
				else if isNil val.id
					return val
					# throw new Error 'remote returned object without id. query, val:' + sify(query) + sify(val)
				else
					return {"#{val.id}": val}

			return val

		# calls TO the cache
		sub: ({key, query, strategy, expiry}) ->
			cache.sub key, query, strategy, expiry
		do: ({query, strategy}) ->
			# if has 'modify', query then cache.do query, strategy, {stack: @stack}
			# else yield cache.do query, strategy, {stack: @stack}
			# cache.do query, strategy, {stack: @stack}
			cache.do query, strategy, {stack: @stack}
			# res = cache.do query, strategy, {stack: @stack}
			# if isThenable res then yield res

	# Shorthands
	Do: -> (_query) ->
		{strategy} = _query
		query = omit ['strategy'], _query
		yield {Cache: 'do', query, strategy}


module.exports = createTree
