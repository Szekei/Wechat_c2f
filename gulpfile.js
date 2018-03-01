var gulp = require('gulp');
var less = require('gulp-less');
var path = require('path');
var minifyCss = require('gulp-minify-css');
var rename = require('gulp-rename');
var coffee = require('gulp-coffee');
var gutil = require('gulp-util');
var uglify = require('gulp-uglify');
var clean = require('gulp-clean');

var modelSrc = './src/model';
var jsSrc = './public/javascripts';
var cssSrc = './public/stylesheets';
var jsDist = './public/dist/js';
var cssDist = './public/dist/css';

gulp.task('less', function () {
  return gulp.src(modelSrc + '/**/*.less')
    .pipe(less({
      paths: [path.join(__dirname, 'less', 'includes')]
    }))
    .pipe(gulp.dest(cssSrc));
});

gulp.task('minify-css', ['less'], function () {
  return gulp.src(cssSrc + '/**/*.css')
    .pipe(minifyCss())
    .pipe(rename({
      extname: '.min.css'
    }))
    .pipe(gulp.dest(cssDist));
});

gulp.task('coffee', function () {
  gulp.src(modelSrc + '/**/*.coffee')
    .pipe(coffee({bare: true}).on('error', gutil.log))
    .pipe(gulp.dest(jsSrc));
});

gulp.task('clean-scripts', function () {
  return gulp.src('jsDist/*.js', {read: false})
    .pipe(clean({
      force: true
    }));
});

gulp.task('uglify', ['coffee', 'clean-scripts'], function () {
  gulp.src(jsSrc + '/**/*.js')
    .pipe(uglify())
    .pipe(rename({
      extname: '.min.js'
    }))
    .pipe(gulp.dest(jsDist));
});

gulp.task('default', ['minify-css', 'uglify']);

gulp.watch(modelSrc + '/**/*.less', ['minify-css']);
gulp.watch(modelSrc + '/**/*.coffee', ['uglify']);