{CompositeDisposable} = require 'atom'
{EventEmitter} = require 'events'
helpers = require 'atom-linter'

module.exports = Language1cBSL =
  subscriptions: null

  activate: (state) ->

    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-text-editor', 'language-1c-bsl:addpipe': => @addpipe()

    @subscriptions.add atom.config.observe 'language-1c-bsl.enableOneScriptLinter', (@enableOneScriptLinter) =>
    @subscriptions.add atom.config.observe 'language-1c-bsl.lintBSLFiles', (@lintBSLFiles) =>

  deactivate: ->
    @subscriptions.dispose()

  addpipe: ->
    editor = atom.workspace.getActiveTextEditor()
    cursorPos = editor.getLastCursor().getBufferPosition()
    beginRow = editor.getLastCursor().getCurrentLineBufferRange().start
    textRow = editor.getTextInBufferRange([beginRow, cursorPos])
    editor.insertText '\n'
    Reg1 = /^\s*\|([^\"]|\"[^\"]*\")*$/
    Reg2 = /^([^\|\"]|\"[^\"]*\")*\"[^\"]*$/
    if (Reg1.exec(textRow) isnt null) or (Reg2.exec(textRow) isnt null)
      editor.insertText '|'

  provideLinter: ->
    name: 'OneScriptLint'
    grammarScopes: ['source.bsl']
    scope: 'file'
    lintOnFly: true # false for lint only on save

    lint: (textEditor) =>
      return [] unless @enableOneScriptLinter

      filePath = textEditor.getPath()
      return [] if filePath.endsWith(".bsl") and not @lintBSLFiles

      # Arguments to checkstyle
      args = []
      args = args.concat(["-encoding=utf-8", "-check", filePath])

      # Execute checkstyle
      helpers.exec("oscript", args, {stream: 'stdout', throwOnStdErr: false})
        .then (val) => @parse(val, textEditor)

  parse: (checkstyleOutput, textEditor) ->
    # Regex to match the error/warning line
    regex = /^\{Модуль\s+(.*)\s\/\s.*:\s+(\d+)\s+\/\s+(.*)\}/
    # Split into lines
    lines = checkstyleOutput.split /\r?\n/
    messages = []
    for line in lines

      if line.match regex
        [file, lineNum, mess] = line.match(regex)[1..3]

        type = "error"

        messages.push
          type: type       # Should be "error" or "warning"
          text: mess       # The error message
          filePath: file   # Full path to file
          range: [[lineNum - 1, 0], [lineNum - 1, Infinity]]
    return messages

  provideBuilder: ->
    class Language1cBSLBuildProvider extends EventEmitter

      constructor: (@cwd) ->

      getNiceName: ->
        '1C (BSL)'

      isEligible: ->
        yes

      settings: ->
        [
          run =
            name: 'OneScript: run',
            sh: false,
            exec: 'oscript',
            args: [ '-encoding=utf-8', '{FILE_ACTIVE}' ],
            errorMatch: [
                '^\\{Модуль (?<file>.+) / Ошибка в строке: (?<line>[0-9]+) / (?<message>.*)\\}$'
            ]

          compile =
            name: 'OneScript: compile',
            sh: false,
            exec: 'oscript',
            args: [ '-encoding=utf-8', '-compile', '{FILE_ACTIVE}' ]

          make =
            name: 'OneScript: make',
            sh: false,
            exec: 'oscript',
            args: [ '-encoding=utf-8', '-make', '{FILE_ACTIVE}', '{FILE_ACTIVE_NAME_BASE}.exe' ]

        ]
