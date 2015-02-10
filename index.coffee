readline = require 'readline'
Stream = require 'stream'

@compare = (a, b, done) ->
	aLines = []
	bLines = []
	closed = no

	check = ->
		if closed
			return
		if aLines.length is 0 or bLines.length is 0
			return
		aLine = aLines.shift()
		bLine = bLines.shift()
		if aLine isnt bLine
			close()
			return done null, no
		if aLine is null
			return done null, yes

	close = ->
		closed = yes
		aRl.close()
		bRl.close()

	panic = (err) ->
		close()
		return done err

	a.on('error', (err) -> panic err)
	aRl = readline.createInterface(input: a, terminal: no)
	.on('line', (line) ->
		aLines.push line
		check()
	)
	.on('close', ->
		aLines.push null
		check()
	)

	b.on('error', (err) -> panic err)
	bRl = readline.createInterface(input: b, terminal: no)
	.on('line', (line) ->
		bLines.push line
		check()
	)
	.on('close', ->
		bLines.push null
		check()
	)
