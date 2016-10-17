const sourceRoot = '../../source/',
    publicRoot = '../../public/',
    serverRoot = '../server/',
    bootstrapRoot = '../node_modules/bootstrap/';

module.exports = {
    source: {
        sass: sourceRoot + 'styles/**/*.scss',
        js: sourceRoot + '*.elm'
    },
    public: {
        sass: publicRoot,
        js: publicRoot,
        fonts: publicRoot + 'fonts'
    },
    server: serverRoot + 'server.js',
    bootstrap: {
        fonts: bootstrapRoot + 'fonts/*',
        sass: bootstrapRoot + 'dist/css/bootstrap.min.css'
    }
};