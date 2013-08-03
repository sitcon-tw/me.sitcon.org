(function() {

  define(['jquery', 'backbone', 'mustache', 'text!javascripts/template/info.js.html'], function($, Backbone, Mustache, infoTemplate) {
    return Backbone.View.extend({
      initialize: function(options) {
        options = options || {};
        this.username = options.username;
        return this.template = infoTemplate;
      },
      render: function() {
        var rendered;
        rendered = Mustache.to_html(this.template, this.model.toJSON);
        return $(this.el).html(rendered);
      }
    });
  });

}).call(this);
