var gulp = require('gulp');
var elm  = require('gulp-elm');
var minifyCSS = require('gulp-minify-css');
var concat = require('gulp-concat');
var minify = require('gulp-minify');
var clean = require('gulp-clean');
var del = require('del')
var sass = require('gulp-sass');
var runSequence = require('run-sequence');

var distDir = 'public/dist/';
var serverDistDir = 'dist/';
var bootstrap = 'node_modules/bootstrap/dist/css/bootstrap.min.css';

var buildDir = 'build/';

/** client tasks **/

// Elm 

gulp.task('elm-init', ['clean:client'], elm.init);

gulp.task('elm-bundle', ['elm-init'], function() {
  gulp.src('client/*.elm')
    .pipe(elm.bundle('bundle.js'))
    .pipe(minify())
    .pipe(gulp.dest(distDir+'js'));
});

// CSS
gulp.task('styles:sass', function() {
    return gulp.src('client/styles/**/*.scss')
        .pipe(sass().on('error', sass.logError))
        .pipe(gulp.dest(buildDir+'css'))
});

gulp.task('styles:concat', function() {
  return gulp.src([buildDir+'css/**/*.css'])
    .pipe(minifyCSS())
    .pipe(concat('style.min.css'))
    .pipe(gulp.dest(distDir+'css'));
});

gulp.task('fonts', function() {
  return gulp.src(['node_modules/bootstrap/fonts/*'])
    .pipe(gulp.dest(distDir+'fonts'));
});

gulp.task('bootstrap', function() {
  return gulp.src(bootstrap).pipe(gulp.dest(distDir+'css'));
});

gulp.task('styles', [ 'clean:client' ], function() {
  runSequence('styles:sass', 'styles:concat', ['fonts', 'bootstrap']);
});

gulp.task('clean:client', function() {
  gulp.src(['public/dist', 'build/css'], { read: false })
    .pipe(clean());
});

gulp.task('rebuild:client', function() {
  runSequence('clean:client', 'elm-bundle', 'styles');
});

gulp.task('client', ['rebuild:client']);
