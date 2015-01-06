Controller = require('scripts/controllers/controller')
Router = require('scripts/routers/router')

App = new Marionette.Application

App.addRegions
  mainRegion: '#main_region'

App.navigate = (route, options) ->
  options or= {}
  Backbone.history.navigate(route, options)

App.on 'start', ->
  @controller = new Controller
  @router = new Router(controller: @controller)

  Backbone.history.start
    pushState: true
    root: '/'

  $(document).on 'click', '.js-link', (event) ->
    event.preventDefault()
    href = $(event.currentTarget).attr('href')
    App.navigate(href, trigger: true)

  console.log 'app started'

module.exports = App
