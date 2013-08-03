define [
  'jquery', 'backbone', 'markdown'
], ($, Backbone, Markdown) ->

  Backbone.View.extend {
    initialize: (options) ->
      options = options || {}
    render: ->
      rendered = Markdown.toHTML @.model.get('content')
      rendered = "<h1>Biography</h1>" + rendered
      $(@.el).html(rendered)
  }
