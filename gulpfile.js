require("require-dir")("./gulp");

// Main gulp setup
var gulp = require('gulp'),
    runSequence = require('run-sequence');

// Build main task
gulp.task('build', function(cb) {
    runSequence( 'styles', 'copy', function() {
        console.log('Setup application: localhost:3000');
        cb();
    });
});
gulp.task('build1', function(cb) {
    runSequence('elm-bundle', 'styles', 'copy', function() {
        console.log('Setup application: localhost:3000');
        cb();
    });
});
// Rebuild source
gulp.task('rebuild1', function(cb) {
    runSequence('clean', 'elm-bundle', 'styles', 'copy', function() {
        console.log('Source ready in the /public folder!');
        cb();
    });
});

gulp.task('rebuild', function(cb) {
    runSequence('clean', 'styles', 'copy', function() {
        console.log('Source ready in the /public folder!');
        cb();
    });
});

// Default
gulp.task('default', function() {
    console.log('No default, buddy!')
});