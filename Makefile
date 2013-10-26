all:
	coffee -c *.coffee
	coffee -c model/*.coffee
	coffee -c public/js/*.coffee

clean:
	rm -f *.js model/*.js public/js/*.js

