var config = require("./config"),
    gulp = require('gulp'),
    minify = require('gulp-minify'),
    concat = require('gulp-concat');

var appTmpl = [ 'intro.html', 'app-outro.html' ].map(file =>
  config.source.templates + file)
var staticTmpl = [ 'intro.html', 'body-static.html', 'outro.html' ].map(file =>
  config.source.templates + file)


gulp.task('html:app', function() {
  gulp
    .src(appTmpl)
    .pipe(concat('index.html'))
    .pipe(gulp.dest('./public/'))
})

gulp.task('html:static', function() {
  console.log(staticTmpl)
  gulp
    .src(staticTmpl)
    .pipe(concat('static.html'))
    .pipe(gulp.dest('./public/'))
})
