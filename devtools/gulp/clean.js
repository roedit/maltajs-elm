// Clean the environment
var config = require("./config"),
    gulp = require('gulp'),
    clean = require('gulp-clean');

gulp.task('clean', function() {
    console.log('Clean the env!');
    gulp.src([config.public.root])
        .pipe(clean({ force: true }));
});