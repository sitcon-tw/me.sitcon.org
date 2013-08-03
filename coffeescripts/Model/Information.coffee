define [
  'backbone'
], (Backbone) ->

  Backbone.Model.extend {
    url: ->
      "https://api.github.com/repos/sitcon-tw/staff-card/contents/#{@.get('username')}/info.json"
    sync: (method, model, options) ->
      options = options || {}
      options.headers = options.headers || {}
      options.headers['Accept'] = "application/vnd.github.raw"

      Backbone.sync method, model, options
  }
