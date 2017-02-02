// Copy usefull resources
var config = require("./config"),
    gulp = require('gulp');

gulp.task('copy:fonts', function() {
    gulp.src([config.bootstrap.fonts])
        .pipe(gulp.dest(config.public.fonts));
});

// todo: fix this mess, it doesn't work
gulp.task('copy:images', function() {
    gulp.src([config.assets.images], { base: 'images'  })
        .pipe(gulp.dest(config.public.images));
});

gulp.task('copy', [ 'copy:fonts', 'copy:images' ]);
