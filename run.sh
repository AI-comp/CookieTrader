rm public/js/*.js model/*.js *.js
find . -type f -name "*.coffee" | while read FILE
do
    coffee -c ${FILE}
done
node app.js
