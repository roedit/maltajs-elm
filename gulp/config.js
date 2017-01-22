const sourceRoot = './source/',
    publicRoot = './public/dist/',
    serverRoot = './server/',
    bootstrapRoot = './node_modules/bootstrap/';

module.exports = {
    source: {
        sass: sourceRoot + 'styles/**/*.scss',
        js: sourceRoot + '**/*.elm'
    },
    public: {
        root: publicRoot,
        sass: publicRoot + 'css/',
        js: publicRoot + 'js',
        fonts: publicRoot + 'fonts'
    },
    server: serverRoot + 'server.js',
    bootstrap: {
        fonts: bootstrapRoot + 'fonts/*'
    }
};