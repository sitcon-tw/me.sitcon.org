(function() {

  define(['backbone'], function(Backbone) {
    return Backbone.Model.extend({
      url: function() {
        return "https://api.github.com/repos/sitcon-tw/staff-card/contents/" + (this.get('username')) + "/info.json";
      },
      sync: function(method, model, options) {
        options = options || {};
        options.headers = options.headers || {};
        options.headers['Accept'] = "application/vnd.github.raw";
        return Backbone.sync(method, model, options);
      }
    });
  });

}).call(this);
