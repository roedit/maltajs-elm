/* Here I need a more complex task that should:
 - generate all css files
 - concat all css files
 - minify all css files
 */
var config = require("./config"),
    gulp = require('gulp'),
    sass = require('gulp-sass'),
    minify = require('gulp-minify-css'),
    concat = require('gulp-concat');

gulp.task('styles', function() {
    gulp.src(config.source.sass)
        .pipe(sass().on('error', sass.logError))
        .pipe(concat())
        .pipe(minify())
        .pipe(gulp.dest(config.public.sass));
});
