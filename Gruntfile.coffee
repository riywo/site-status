module.exports = (grunt) ->
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-release'

  grunt.initConfig
    coffee:
      lib:
        expand: true
        cwd: 'lib'
        src: ['**/*.coffee']
        dest: 'build/lib'
        ext: '.js'

    watch:
      lib:
        files: ['lib/**/*.coffee']
        tasks: ['coffee:lib']

  grunt.registerTask 'default', ['coffee', 'watch']
