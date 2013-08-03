define [
  'jquery', 'backbone', 'markdown'
], ($, Backbone, Markdown) ->

  Backbone.View.extend {
    initialize: (options) ->
      options = options || {}
    render: ->
      rendered = Markdown.toHTML @.model.get('content')
      $(@.el).html(rendered)
  }
