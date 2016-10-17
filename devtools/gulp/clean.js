// Clean the environment
var config = require("./config"),
    gulp = require('gulp');

gulp.task('clean', function() {
    console.log('Clean the env!');
    gulp.src(['dist', 'public/dist', 'build'], { read: false })
        .pipe(clean());
});