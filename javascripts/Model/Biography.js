(function() {

  define(['jquery', 'backbone'], function($, Backbone, Markdown) {
    return Backbone.Model.extend({
      url: function() {
        return "https://api.github.com/repos/sitcon-tw/staff-card/contents/" + (this.get('username')) + "/biography.md";
      },
      sync: function(method, model, options) {
        /*
              This code not work, do it by myself
              options = options || {}
              options.headers = options.headers || {}
              options.headers['Accept'] = "application/vnd.github.raw"
        
              Backbone.sync method, model, options
        */

        var self;
        self = this;
        return $.ajax({
          headers: {
            'Accept': 'application/vnd.github.raw'
          },
          url: self.url(),
          success: function(data, xhr) {
            self.parse(data, xhr);
            return self.trigger('sync', self);
          }
        });
      },
      parse: function(res, options) {
        this.set('content', res);
        return {
          content: res
        };
      }
    });
  });

}).call(this);
