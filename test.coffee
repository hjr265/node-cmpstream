assert = require 'assert'
cmpstream = require './index'
streamBuffers = require 'stream-buffers'

makeStream = (data) ->
	s = new streamBuffers.ReadableStreamBuffer
		frequency: 10
		chunkSize: 2048
	s.put data
	s.destroySoon()
	return s

describe '#compare()', ->
	it 'should work with streams containing same data', (done) ->
		cmpstream.compare makeStream('Hello\nworld\n'), makeStream('Hello\nworld\n'), (err, same) =>
			assert.ifError err
			assert same
			done()

	it 'should work with streams containing different data', (done) ->
		cmpstream.compare makeStream('Hello\nworld\n'), makeStream('Hello\nearth\n'), (err, same) =>
			assert.ifError err
			assert not same
			done()
