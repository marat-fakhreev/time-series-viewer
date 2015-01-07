template = require('templates/plot')

class PlotView extends Marionette.ItemView
  template: template

  ui:
    'container': '.plot-container'

  onRender: ->
    params =
      series:
        lines:
          show: true
        points:
          show: true
          radius: 2
        shadowSize: 2
      xaxis:
        tickSize: @model.get('x_step_value')
        tickDecimals: 0
        min: @model.get('x_low_value')
        max: @model.get('x_top_value')
      yaxis:
        tickSize: @model.get('y_step_value')
        tickDecimals: 0
        min: @model.get('y_low_value')
        max: @model.get('y_top_value')

    graphData = [
      label: @model.get('title')
      data: @model.get('coordinates')
      color: @model.collection.indexOf(@model)
    ]

    setTimeout(=>
      $.plot(@ui.container, graphData, params)
    , 10)

module.exports = PlotView
