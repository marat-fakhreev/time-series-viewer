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
          radius: 1
        shadowSize: 2
      grid:
        margin:
          left: 50
          top: 0
          right: 0
          bottom: 0
      xaxis:
        tickSize: @model.get('x_step_value')
        tickDecimals: 0
        min: @model.get('x_low_value')
        max: @model.get('x_top_value')
        position: 'bottom'
      yaxis:
        tickSize: @model.get('y_step_value')
        tickDecimals: 0
        min: @model.get('y_low_value')
        max: @model.get('y_top_value')
        position: 'left'
        alignTicksWithAxis: 'right'

    graphData = [{
      label: @model.get('title')
      data: @model.get('coordinates')
      color: 'purple'
    }]

    $.plot(@ui.container, graphData, params)

module.exports = PlotView
