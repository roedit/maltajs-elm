var config = require("./config"),
    gulp = require('gulp'),
    elm  = require('gulp-elm'),
    minify = require('gulp-minify');

// Elm tasks
gulp.task('elm-init', elm.init);

gulp.task('elm-bundle', ['elm-init'], function() {
    console.log('Bundling the ELM!');
    gulp.src(config.source.js)
        .pipe(elm.bundle())
        .pipe(minify())
        .pipe(gulp.dest(config.public.js));
});