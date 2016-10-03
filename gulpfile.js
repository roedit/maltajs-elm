var gulp = require('gulp');
var elm  = require('gulp-elm');
var minifyCSS = require('gulp-minify-css');
var concat = require('gulp-concat');
var minify = require('gulp-minify');
var clean = require('gulp-clean');

var    exec = require('child_process').exec;

var distDir = 'public/dist/';
var serverDistDir = 'dist/';

var buildDir = 'build/';

gulp.task('default', function() {
  // place code for your default task here
  console.log('no default, buddy!')
});

// Clean
gulp.task('clean', () =>
  gulp.src(['dist', 'public/dist', 'build'], { read: false })
    .pipe(clean())
);

gulp.task('build', [ 'clean', 'js', 'elm-bundle', 'styles'], () =>
  console.log(`application ready! type 'npm start' and go to 'localhost:3000'`)
)

// Elm tasks 

gulp.task('elm-init', elm.init);

gulp.task('elm-bundle', ['elm-init'], () =>
  gulp.src('client/*.elm')
    .pipe(elm.bundle('bundle.js'))
    .pipe(minify())
    .pipe(gulp.dest(`${distDir}js`))
);

// CSS related tasks

gulp.task('styles:site', () => 
  gulp.src(['client/styles/**/*.css'])
    .pipe(minifyCSS())
    .pipe(concat('style.min.css'))
    .pipe(gulp.dest(`${buildDir}css`))
);

gulp.task('fonts', () =>
  gulp.src(['node_modules/bootstrap/fonts/*'])
    .pipe(gulp.dest(`${distDir}fonts`))
);

gulp.task('styles', ['styles:site', 'fonts'], () =>
  gulp.src([
    'node_modules/bootstrap/dist/css/bootstrap.min.css',
    `${buildDir}**/*.css`
  ])
    .pipe(concat('style.min.css'))
    .pipe(gulp.dest(`${distDir}css`))
);

// Server

gulp.task('js', () =>
  gulp.src('server/**/*.js')
    .pipe(concat('server.js'))
    .pipe(minify())
    .pipe(gulp.dest(serverDistDir))
);
