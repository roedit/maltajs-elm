// Have to do it smarter then require everything
var gulp = require('gulp');
var elm  = require('gulp-elm');
var minifyCSS = require('gulp-minify-css');
var concat = require('gulp-concat');
var minify = require('gulp-minify');
var clean = require('gulp-clean');
var sass = require('gulp-sass');
var bootstrap = 'node_modules/bootstrap/dist/css/bootstrap.min.css';

// Some folders
var distDir = 'public/dist/';
var buildDir = 'build/';

// Default
gulp.task('default', function() {
  console.log('No default, buddy!')
});

// Build main task
gulp.task('build', [ 'clean', 'elm-bundle', 'styles'], function() {
  console.log('application ready! type `npm start` and go to `localhost:3000`');
});

// Build client
gulp.task('build:client', [ 'elm-bundle', 'styles' ], function() {
  console.log('client ready in the /public folder!');
});

// Rebuild client
gulp.task('rebuild:client', [ 'clean', 'elm-bundle', 'styles' ], function() {
  console.log('client ready in the /public folder!');
});

// Clean
gulp.task('clean', function() {
  gulp.src(['dist', 'public/dist', 'build'], { read: false })
      .pipe(clean());
});

// Elm tasks
gulp.task('elm-init', elm.init);

gulp.task('elm-bundle', ['elm-init'], function() {
  gulp.src('client/*.elm')
    .pipe(elm.bundle('bundle.js'))
    .pipe(minify())
    .pipe(gulp.dest(distDir+'js'));
});

// CSS related tasks
gulp.task('styles:sass', function() {
    gulp.src('client/styles/**/*.scss')
        .pipe(sass().on('error', sass.logError))
    .pipe(gulp.dest(buildDir+'css'))
});

gulp.task('styles:concat', function() {
  gulp.src([buildDir+'css/**/*.css'])
    .pipe(minifyCSS())
    .pipe(concat('style.min.css'))
    .pipe(gulp.dest(buildDir+'css'));
});

gulp.task('fonts', function() {
  gulp.src(['node_modules/bootstrap/fonts/*'])
    .pipe(gulp.dest(distDir+'fonts'));
});

gulp.task('styles', ['styles:sass', 'styles:concat', 'fonts'], function() {
  gulp.src([
    bootstrap,
    buildDir+'**/*.css'
  ])
    .pipe(concat('style.min.css'))
    .pipe(gulp.dest(distDir+'css'));
});
