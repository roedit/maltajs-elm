require("require-dir")("./gulp");

// Main gulp setup
var gulp = require('gulp');

// Build main task
gulp.task('build', ['elm-bundle', 'styles', 'copy'], function() {
    console.log('Setup application: localhost:3000');
});

// Rebuild source
gulp.task('rebuild', [ 'clean', 'elm-bundle', 'styles', 'copy'], function() {
    console.log('source ready in the /public folder!');
});

// Default
gulp.task('default', function() {
    console.log('No default, buddy!')
});