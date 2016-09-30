var gulp = require('gulp');
var elm  = require('gulp-elm');
var    exec = require('child_process').exec;

var buildDir = 'dist/';

gulp.task('default', function() {
  // place code for your default task here
});

gulp.task('elm-init', elm.init);

gulp.task('elm-bundle', ['elm-init'], function(){
  return gulp.src('client/*.elm')
    .pipe(elm.bundle('bundle.js'))
    .pipe(gulp.dest('public/'));
});

gulp.task('js', function() {
    return gulp.src('server/**/*.js')
        // .pipe(plumber({ errorHandler: onError }))
        // .pipe(changed(buildDir + 'js'))
        .pipe(gulp.dest(buildDir))
        // .pipe(livereload());
});

// proudly copied from http://stackoverflow.com/questions/28048029/running-a-command-with-gulp-to-start-node-js-server
gulp.task('server', function (cb) {
  exec('node dist/server.js', function (err, stdout, stderr) {
    console.log(stdout);
    console.log(stderr);
    cb(err);
  });
})