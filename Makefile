all:
	mkdir -p server
	mkdir -p public/js
	mkdir -p test
	coffee -o server -c coffee/server/*.coffee 
	coffee -o server -c coffee/common/*.coffee
	mv -f server/app.js .
	-cp -f coffee/server/*.json server/
	-cp -f coffee/common/*.json server/
	coffee -o public/js -c coffee/client/*.coffee 
	coffee -o public/js -c coffee/common/*.coffee 
	-cp -f coffee/client/*.json public/js/
	-cp -f coffee/common/*.json public/js/
	coffee -o test -c coffee/test/*.coffee 

clean:
	rm -fR server public/js test *.js
