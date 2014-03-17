{WorkspaceView} = require 'atom'
copyToHipchat = require '../lib/copy-to-hipchat'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "CopyToHipchat", ->
  promise = null
  beforeEach ->
    atom.workspaceView = new WorkspaceView()
    atom.workspace = atom.workspaceView.model
    promise = atom.packages.activatePackage('copy-to-hipchat')
    waitsForPromise ->
      atom.workspace.open()

  it "copies", ->
    atom.workspaceView.trigger 'copy-to-hipchat:copy'
    waitsForPromise ->
      promise
  it "requires a selection", ->
    editor = atom.workspaceView.getActivePaneItem()
    selection = editor.getSelection()
    selection.selectAll()
    title = editor.getTitle()
    atom.workspaceView.trigger("copy-to-hipchat:copy")
    text = atom.clipboard.read()
    expect( text ).toEqual('initial clipboard content')
    waitsForPromise ->
      promise
  it "appends `/code`", ->
    editor = atom.workspaceView.getActivePaneItem()
    editor.setText("abcd")
    selection = editor.getSelection()
    selection.selectAll()
    atom.workspaceView.trigger("copy-to-hipchat:copy")
    text = atom.clipboard.read()
    waitsForPromise ->
      promise
    expect(text).toMatch(/\/code/)
  it "appends title", ->
    editor = atom.workspaceView.getActivePaneItem()
    editor.setText("abcd")
    selection = editor.getSelection()
    selection.selectAll()
    title = editor.getTitle()
    atom.workspaceView.trigger("copy-to-hipchat:copy")
    text = atom.clipboard.read()
    waitsForPromise ->
      promise
    expect(text).toMatch(title)
