del public\js\*.js && FOR %%f IN (public\js\*.coffee) DO (
	coffee -c %%f
) && coffee app.coffee