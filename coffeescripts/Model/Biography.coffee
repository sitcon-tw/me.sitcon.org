define [
  'jquery', 'backbone'
], ($, Backbone, Markdown)->

  Backbone.Model.extend {
    url: ->
      "https://api.github.com/repos/sitcon-tw/staff-card/contents/#{@.get('username')}/biography.md"
    sync: (method, model, options) ->
      ###
      This code not work, do it by myself
      options = options || {}
      options.headers = options.headers || {}
      options.headers['Accept'] = "application/vnd.github.raw"

      Backbone.sync method, model, options
      ###
      self = @
      $.ajax {
        headers: {
          'Accept': 'application/vnd.github.raw'
        }
        url: self.url()
        success: (data, xhr) ->
          self.parse(data, xhr)
          self.trigger 'sync', self
      }

    parse: (res, options) ->
      @.set('content', res)
      {content: res}
  }
