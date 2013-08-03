(function() {

  define(['jquery', 'backbone', 'require', 'Model/Information', 'Model/Biography', 'View/InformationView', 'View/BiographyView'], function($, Backbone) {
    return Backbone.Router.extend({
      initialize: function() {
        return this.el = $("#app");
      },
      routes: {
        '': 'index',
        ':username': 'userPage'
      },
      index: function() {
        return console.log("Index");
      },
      userPage: function(username) {
        var Biography, BiographyView, Information, InformationView, bio, bioView, info, infoView;
        Information = require('Model/Information');
        Biography = require('Model/Biography');
        InformationView = require('View/InformationView');
        BiographyView = require('View/BiographyView');
        info = new Information({
          username: username
        });
        bio = new Biography({
          username: username
        });
        infoView = new InformationView({
          el: $("#info"),
          model: info
        });
        bioView = new BiographyView({
          el: $("#bio"),
          model: bio
        });
        info.fetch();
        bio.fetch();
        info.on('sync', function(model) {
          return infoView.render();
        });
        return bio.on('sync', function(model) {
          return bioView.render();
        });
      }
    });
  });

}).call(this);
