elm:
	elm-make source/Main.elm --output=public/assets/js/app-min.js
	node_modules/.bin/elm-static-html -c elm-static-html.json
templates:
	gulp html:app
	gulp html:static
styles:
	gulp styles
clean:
	gulp clean
copy:
	gulp copy
	# can't use gulp properly, I'm sorry
	cp -r source/images public/assets
all: clean elm templates styles copy

