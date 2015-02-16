mainBowerOnefile=
  bin: ->
    commander= require 'commander'
    commander
      .version require('./package.json').version
      .usage 'name[.js] [options...]'
      .option '-u, --uglifyjs        ','Use UglifyJS2 (Experimental)'
      .option '-s, --sourcemap       ','Use UglifyJS2 sourcemap (Experimental)'
      .option '-j, --json      <path>','Use <bower.json>'      ,'bower.json'
      .option '-d, --directory <path>','Use <bower_components>','bower_components'
      .option '-r, --rc        <path>','Use <.bowerrc>'        ,'.bowerrc'
      .option '-v, --verbose         ','Output filenames'
      .parse process.argv
    commander.help() if commander.args.length is 0

    path  = require 'path'
    Gulp  = require 'gulp'
    mbf   = require 'main-bower-files'
    jsfy  = require 'gulp-jsfy'
    concat= require 'gulp-concat'

    filename= commander.args[0]
    filename+= '.js' if filename.match(/.js$/) is null
    filenameMin= filename.replace /.js$/,'.min.js'
    
    basename= path.basename filename
    dirname= path.dirname path.resolve process.cwd(),filename
    mbfOptions= 
      paths:
        bowerJson     : path.resolve process.cwd(),commander.json
        bowerDirectory: path.resolve process.cwd(),commander.directory
        bowerrc       : path.resolve process.cwd(),commander.rc
    
    gulp= Gulp.src (mbf mbfOptions).concat ['!**/*.!(*js|*css)']# Ignore unsupport extension
    gulp.on 'data',(file)-> console.log 'Add',path.relative process.cwd(),file.path if commander.verbose
    gulp= gulp.pipe jsfy dataurl:true
    gulp= gulp.pipe concat basename
    gulp= gulp.pipe Gulp.dest dirname
    gulp.on 'end',->
      console.log 'Compiled',filename
      process.exit() if commander.uglifyjs is undefined

      exec= require('child_process').exec
      execFilename= path.resolve process.cwd(),filename
      execFilenameMin= path.resolve process.cwd(),filenameMin
      execScript= "uglifyjs #{execFilename} -o #{execFilenameMin}"
      execScript+= " --source-map #{execFilenameMin}.map" if commander.sourcemap
      exec execScript,(stderr)->
        throw stderr if stderr?
        
        console.log 'Compiled',filenameMin
        console.log 'Compiled',filenameMin+'.map' if commander.sourcemap
        process.exit()

module.exports= mainBowerOnefile
###                               _____  _____
                                 /      /    /
                                /____  /____/
                                    /      /
                              _____/ _____/
###