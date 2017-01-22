// Copy usefull resources
var config = require("./config"),
    gulp = require('gulp');

gulp.task('copy', function() {
    gulp.src([config.bootstrap.fonts])
        .pipe(gulp.dest(config.public.fonts));
});