// Copy usefull resources
var config = require("./config"),
    gulp = require('gulp');

gulp.task('fonts', function() {
    gulp.src([config.bootstrap.fonts])
        .pipe(gulp.dest(config.public.fonts));
});