var config = require("./config"),
    gulp = require('gulp'),
    elm  = require('gulp-elm'),
    minify = require('gulp-minify');
    exec = require('gulp-exec');

// Elm tasks
gulp.task('elm-init', elm.init);

gulp.task('elm-bundle', ['elm-init'], function() {
    console.log('Bundling the ELM!');
    gulp.src(config.source.js)
        .pipe(elm.bundle('app.js'))
        .pipe(minify())
        .pipe(gulp.dest(config.public.js));
});

gulp.task('elm', function() {
    gulp.src(config.source.js)
        .pipe(exec('elm-make source/Main.elm --output public/dist/js/app.js'))
});

