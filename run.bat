DEL *.js
DEL model\*.js
DEL public\js\*.js
DEL test\*.js
FOR /r %%f IN (*.coffee) DO (
	call coffee -c %%f
)
call node app.js
