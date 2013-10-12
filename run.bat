DEL public\js\*.js
FOR %%f IN (public\js\*.coffee) DO (
	call coffee -c %%f
)
call coffee app.coffee