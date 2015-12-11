{CompositeDisposable} = require 'atom'
{EventEmitter} = require 'events'

module.exports = Language1cBSL =
  subscriptions: null

  activate: (state) ->

    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-text-editor', 'language-1c-bsl:addpipe': => @addpipe()

  deactivate: ->
    @subscriptions.dispose()

  addpipe: ->
    editor = atom.workspace.getActiveTextEditor()
    editor.insertText('\n')
    scope = editor.getLastCursor().getScopeDescriptor().toString()
    if scope==".source.bsl .string.quoted.double.bsl"
      editor.insertText('|')

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
            args: [ '-encoding=utf-8', '-make', '{FILE_ACTIVE}' ]

        ]
