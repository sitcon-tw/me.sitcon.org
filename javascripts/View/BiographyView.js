(function() {

  define(['jquery', 'backbone', 'markdown'], function($, Backbone, Markdown) {
    return Backbone.View.extend({
      initialize: function(options) {
        return options = options || {};
      },
      render: function() {
        var rendered;
        rendered = Markdown.toHTML(this.model.get('content'));
        return $(this.el).html(rendered);
      }
    });
  });

}).call(this);
