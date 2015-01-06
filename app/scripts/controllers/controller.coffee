ReqRes = require('scripts/facades/reqres')
Layout = require('scripts/views/layout')
FileView = require('scripts/views/file_view')
PlotsView = require('scripts/views/plots_view')

class AppController extends Marionette.Controller
  initialize: ->
    @layout = new Layout
    @model = new Backbone.Model
    @collection = new Backbone.Collection

  root: ->
    @layout.mainRegion.show(new FileView)

  allPlots: ->
    @data = ReqRes.request('get:data') unless @data?
    @layout.mainRegion.show(new PlotsView(collection: new Backbone.Collection(@data)))

  onePlot: ->
    @data = ReqRes.request('get:data') unless @data?

module.exports = AppController
