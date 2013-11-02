all:
	coffee -c *.coffee
	coffee -c model/*.coffee
	coffee -c public/js/*.coffee
	coffee -c test/*.coffee

clean:
	rm -f *.js model/*.js public/js/*.js test/*.js

