// Start nodemon
var config = require("./config"),
    gulp = require('gulp'),
    nodemon = require('gulp-nodemon');

gulp.task('server', function () {
    console.log('Starting the server!');
    nodemon({
        script: config.server,
        ext: 'js html',
        env: { 'NODE_ENV': 'development' }
    })
});