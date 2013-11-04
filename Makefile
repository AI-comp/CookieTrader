all:
	mkdir js
	mkdir test
	mkdir public/js
	coffee -o js -c coffee/server/*.coffee 
	coffee -o js -c coffee/common/*.coffee 
	coffee -o public/js -c coffee/common/*.coffee 
	coffee -o public/js -c coffee/client/*.coffee 
	coffee -o test -c coffee/test/*.coffee 

clean:
	rm -f *.js model/*.js public/js/*.js test/*.js
