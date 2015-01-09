Layout = require('scripts/views/layout')
PlotsView = require('scripts/views/plots_view')
SinglePlotView = require('scripts/views/single_plot_view')

class AppController extends Marionette.Controller
  initialize: ->
    @layout = new Layout
    @model = new Backbone.Model
    @collection = new Backbone.Collection

  allPlots: ->
    @layout.setNav('')
    @data = JSON.parse(localStorage.getItem('data')) unless @data?
    @layout.mainRegion.show(new PlotsView(collection: new Backbone.Collection(@data)))

  singlePlot: ->
    @layout.setNav('single_plot')
    @data = JSON.parse(localStorage.getItem('data')) unless @data?

    model = new Backbone.Model({
      x_low_value: @_setMin('x_low_value')
      y_low_value: @_setMin('y_low_value')
      x_top_value: @_setMax('x_top_value')
      y_top_value: @_setMax('y_top_value')
      x_step_value: @_setMax('x_step_value')
      y_step_value: @_setMax('y_step_value')
      data: @_setData()
    })

    @layout.mainRegion.show(new SinglePlotView(model: model))

  _setMin: (key) ->
    _.chain(@data).min((item) -> item[key]).value()[key]

  _setMax: (key) ->
    _.chain(@data).max((item) -> item[key]).value()[key]

  _setData: ->
    _.chain(@data)
      .map((item, index) ->
        item.color = index + 1
        item.data = item.coordinates
        item.label = item.title
        _.pick(item, 'data', 'label', 'color')
      )
      .indexBy('label')
      .value()

module.exports = AppController
