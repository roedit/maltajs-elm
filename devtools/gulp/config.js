const sourceRoot = '../../source/',
    publicRoot = '../../public/',
    serverRoot = '../../server/',
    bootstrapRoot = '../node_modules/bootstrap/';

module.exports = {
    source: {
        sass: sourceRoot + 'styles/**/*.scss',
        js: sourceRoot + '*.elm'
    },
    public: {
        sass: publicRoot + 'styles.min.css',
        js: publicRoot + 'app.min.js',
        fonts: publicRoot + 'fonts'
    },
    server: serverRoot + 'server.js',
    bootstrap: {
        fonts: bootstrapRoot + 'fonts/*',
        sass: bootstrapRoot + 'dist/css/bootstrap.min.css'
    }
};