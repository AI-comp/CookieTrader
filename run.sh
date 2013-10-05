find public/js -type f -name *.coffee | while read FILE
do
    coffee -c ${FILE}
done
coffee app.coffee