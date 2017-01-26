const sourceRoot = './source/',
    publicRoot = './public/assets/dist/',
    serverRoot = './server/',
    bootstrapRoot = './node_modules/bootstrap/';

module.exports = {
    source: {
        sass: sourceRoot + 'styles/**/*.scss',
        js: sourceRoot + '**/*.elm',
        templates: sourceRoot + 'templates/',
    },
    public: {
        root: publicRoot,
        sass: publicRoot + 'css/',
        js: publicRoot + 'js',
        fonts: publicRoot + 'fonts',
        html: publicRoot
    },
    server: serverRoot + 'server.js',
    bootstrap: {
        fonts: bootstrapRoot + 'fonts/*'
    }
};
