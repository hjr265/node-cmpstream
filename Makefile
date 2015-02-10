PATH := ./node_modules/.bin:${PATH}

all: index.js

clean:
	rm -rf index.js

index.js: index.coffee
	coffee -c $^

test: index.js test.coffee
	mocha -u bdd -R spec --compilers coffee:coffee-script/register test.coffee
