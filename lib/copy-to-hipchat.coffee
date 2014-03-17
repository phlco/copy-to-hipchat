module.exports =
  activate: ->
    atom.workspaceView.command "copy-to-hipchat:copy", => @copy()

  copy: ->
    editor    = atom.workspace.activePaneItem
    selection = editor.getSelection()
    text      = selection.getText()

    if (text)
      title     = editor.getTitle()
      scopes    = editor.getCursorScopes()

      commentStart = atom.syntax.getProperty(scopes, 'editor.commentStart') || ""
      commentEnd   = atom.syntax.getProperty(scopes, 'editor.commentEnd')   || ""
      commentedTitle = "#{commentStart}#{title}#{commentEnd}"

      clipboard = atom.clipboard
      clipboard.write("/code #{commentedTitle}\n#{text}")
    else
      console.error("Requires a selection")
