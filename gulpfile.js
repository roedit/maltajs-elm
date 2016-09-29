var gulp = require('gulp');
var elm  = require('gulp-elm');

gulp.task('default', function() {
  // place code for your default task here
});

gulp.task('elm-init', elm.init);

gulp.task('elm-bundle', ['elm-init'], function(){
  return gulp.src('client/*.elm')
    .pipe(elm.bundle('bundle.js'))
    .pipe(gulp.dest('public/'));
});