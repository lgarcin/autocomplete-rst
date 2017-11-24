AutocompleteRstView = require './autocomplete-rst-view'
{CompositeDisposable} = require 'atom'

module.exports = AutocompleteRst =
  autocompleteRstView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @autocompleteRstView = new AutocompleteRstView(state.autocompleteRstViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @autocompleteRstView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'autocomplete-rst:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @autocompleteRstView.destroy()

  serialize: ->
    autocompleteRstViewState: @autocompleteRstView.serialize()

  toggle: ->
    console.log 'AutocompleteRst was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
