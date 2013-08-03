define [
  'jquery', 'backbone', 'require',
  # Models
  'Model/Information', 'Model/Biography'
  # View
  'View/InformationView', 'View/BiographyView'
], ($, Backbone) ->

  Backbone.Router.extend {
    initialize: ->
      @.el = $("#app")

    routes: {
      '': 'index',
      ':username': 'userPage'
    }
    index: ->
      # notings
      console.log "Index"

    userPage: (username) ->
      Information = require('Model/Information')
      Biography = require('Model/Biography')

      InformationView = require('View/InformationView')
      BiographyView = require('View/BiographyView')

      info = new Information {username: username}
      bio = new Biography {username: username}

      infoView = new InformationView {el: $("#info .content"), model: info}
      bioView = new BiographyView {el: $("#bio .content"), model: bio}

      info.fetch()
      bio.fetch()

      info.on 'sync', (model) ->
        infoView.render()
      bio.on 'sync', (model) ->
        bioView.render()
  }
