'use strict';

// Include dependencies
var gulp = require('gulp');
var $ = require('gulp-load-plugins')();
var autoprefixer = require('autoprefixer');

// Fetch import settings
var jsImports = require('./javascripts/gulp-imports');

var runTimestamp = Math.round(Date.now()/1000);
var fontName = 'font-icons';
var fontPath = '../fonts/';
var cssProcessors = [
    autoprefixer({
      browsers: ['last 2 versions', 'ie >= 9'],
      cascade: false
    })
];

// -------------------------------------------
// Sass tasks
// Using gulp-sass
// https://www.npmjs.com/package/gulp-sass

gulp.task('sass', function () {
  return gulp
    .src('sass/**/*.scss')
    .pipe($.plumber())
    // Initiate sourcemaps
    .pipe($.sourcemaps.init())
    // Convert sass into css
    .pipe($.sass({
      // sourcemap: true,
      errLogToConsole: true
    }))
    // Catch any SCSS errors and prevent them from crashing gulp
    .on('error', function (error) {
        console.error(error);
        this.emit('end');
    })
    // Prefix CSS3 properties for browsersupport
    .pipe($.postcss(cssProcessors))
    // Write out source maps
    .pipe($.sourcemaps.write())
    // Save the CSS
    .pipe(gulp.dest('../assets/stylesheets'));
});

gulp.task('sass-production', function () {
  return gulp
    .src('sass/**/*.scss')
    .pipe($.plumber())
    .pipe($.sass({
      outputStyle: 'compressed',
      errLogToConsole: true
    }))
    .pipe($.postcss(cssProcessors))
    .pipe(gulp.dest('../assets/stylesheets'));
});

// -------------------------------------------
// Javascript tasks
// Using gulp-uglifyjs
// https://www.npmjs.com/package/gulp-uglifyjs

gulp.task('javascripts', function() {
  return gulp
    .src(jsImports)
    .pipe($.plumber())
    .pipe($.sourcemaps.init())
    .pipe($.jshint())
    .pipe($.jshint.reporter($.stylish))
    .pipe($.concat('main.js'))
    .pipe($.uglify({
      outSourceMap: true,
      output: {
        beautify: true
      }
    }))
    .pipe($.sourcemaps.write())
    .pipe(gulp.dest('../assets/javascripts/'));
});

gulp.task('javascripts-production', function() {
  return gulp
    .src(jsImports)
    .pipe($.plumber())
    .pipe($.concat('main.js'))
    .pipe($.uglify({
      compress: {
        warnings : true
      }
    }))
    .pipe(gulp.dest('../assets/javascripts/'));
});

// -------------------------------------------
// SVG builder
// Using:
// gulp-iconfont
// gulp-consolidate
// gulp-rename
// lodash
// https://www.npmjs.com/package/gulp-iconfont
// https://github.com/backflip/gulp-iconfont-css/issues/9#issuecomment-39631838

gulp.task('iconfont', function(){
  return gulp.src(['font-icons/svg/*.svg'])
    .pipe($.iconfont({
      // https://github.com/nfroidure/svgicons2svgfont#svgicons2svgfontoptions
      fontName: fontName,
      normalize: true,
      fontHeight: 1001,
      formats: ['ttf', 'eot', 'woff'], // default, 'woff2' and 'svg' are available
      timestamp: runTimestamp // recommended to get consistent builds when watching files
    }))
    .on('glyphs', function(glyphs, options) {
      // CSS templating, e.g.
      gulp.src('font-icons/_sass-template.scss')
        .pipe($.consolidate('lodash', {
          glyphs: glyphs,
          fontName: fontName,
          fontPath: fontPath + 'icon-font/' // set path to font (from your CSS file if relative)
        }))
        .pipe($.rename({ basename: '_font-icon-settings' }))
        .pipe(gulp.dest('sass/')); // set path to export your CSS
    })
    .pipe(gulp.dest('../assets/fonts/icon-font/')); // set path to export your fonts
});

// -------------------------------------------
// Setting up common tasks

// Watch Files For Changes & Reload
gulp.task('watch', function() {
  gulp.start(['iconfont', 'sass', 'javascripts']);
  gulp.watch('font-icons/svg/*.svg', ['iconfont']);
  gulp.watch('sass/**/*.scss', ['sass']);
  gulp.watch('javascripts/**/*.js', ['javascripts']);
});

// Compile for development
gulp.task('development', ['iconfont', 'sass', 'javascripts']);

// Compile for production
gulp.task('production', ['iconfont', 'sass-production', 'javascripts-production']);

// Default task
gulp.task('default', ['development']);