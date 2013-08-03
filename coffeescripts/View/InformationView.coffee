define [
  'jquery', 'backbone', 'mustache', 'text!javascripts/template/info.js.html'
], ($, Backbone, Mustache, infoTemplate) ->

  Backbone.View.extend {
    initialize: (options) ->
      options = options || {}
      @.template = infoTemplate
    render: ->
      rendered = Mustache.to_html @.template, @.model.toJSON()
      $(@.el).html(rendered)
  }
