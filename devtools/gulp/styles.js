/* Here I need a more complex task that should:
 - generate all css files
 - concat all css files
 - minify all css files
 */
var config = require("./config"),
    gulp = require('gulp'),
    sass = require('gulp-sass'),
    minify = require('gulp-clean-css'),
    sourcemaps = require('gulp-sourcemaps'),
    concat = require('gulp-concat');

gulp.task('styles', function() {
    gulp.src(config.source.sass)
        .pipe(sourcemaps.init())
        .pipe(sass({outputStyle: 'compressed'}).on('error', sass.logError))
        .pipe(concat('styles.min.css'))
        .pipe(minify())
        .pipe(sourcemaps.write(config.public.sass))
        .pipe(gulp.dest(config.public.sass));
});
