all:
	elm-make source/Main.elm --output=public/dist/js/app-min.js
	elm-static-html -c elm-static-html.json
	gulp html:app
	gulp html:static
	gulp styles
	gulp copy
clean:
	gulp clean

