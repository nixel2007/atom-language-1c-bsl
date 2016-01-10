{CompositeDisposable} = require 'atom'

module.exports = Language1cBSL =
  subscriptions: null

  activate: (state) ->

    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-text-editor', 'language-1c-bsl:addpipe': => @addpipe()

  deactivate: ->
    @subscriptions.dispose()

  addpipe: ->
    editor = atom.workspace.getActiveTextEditor()
    editor.insertText '\n'
    scope = editor.getLastCursor().getScopeDescriptor().toString()
    if scope is '.source.bsl .string.quoted.double.bsl'
      editor.insertText '|'
