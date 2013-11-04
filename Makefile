all:
	mkdir -p app
	mkdir -p public/js
	mkdir -p test
	coffee -o app -c coffee/server/*.coffee 
	coffee -o app -c coffee/common/*.coffee 
	coffee -o public/js -c coffee/common/*.coffee 
	coffee -o public/js -c coffee/client/*.coffee 
	coffee -o test -c coffee/test/*.coffee 

clean:
	rm -fR app public/js test
