// Copy usefull resources
var config = require("./config"),
    gulp = require('gulp');

gulp.task('copy:fonts', function() {
    gulp.src([config.bootstrap.fonts])
        .pipe(gulp.dest(config.public.fonts));
});

gulp.task('copy:images', function() {
    gulp.src([config.assets.images])
        .pipe(gulp.dest(config.public.images));
});

gulp.task('copy', [ 'copy:fonts', 'copy:images' ]);
