template = require('templates/one_plot')

class OnePlotView extends Marionette.ItemView
  template: template

  ui:
    'container': '.plot'
    'list': '.choise-list'
    'checker': 'input:checkbox'

  events:
    'click @ui.checker': 'onPlotAccordingToChoices'

  onRender: ->
    @params =
      series:
        lines:
          show: true
        points:
          show: true
          radius: 2
        shadowSize: 2
      xaxis:
        tickDecimals: 0
        tickSize: @model.get('x_step_value')
        min: @model.get('x_low_value')
        max: @model.get('x_top_value')
      yaxis:
        tickDecimals: 0
        tickSize: @model.get('y_step_value')
        min: @model.get('y_low_value')
        max: @model.get('y_top_value')

    @_renderCheckboxes()
    @_renderPlot()

  onPlotAccordingToChoices: ->
    @_renderPlot()

  _renderCheckboxes: ->
    $.each @model.get('data'), (key, val) =>
      @ui.list.append("<li><input type=checkbox name=#{key} checked=checked id=id#{key}></input><label for=id#{key}>#{val.label}</label></li>")

    @bindUIElements()

  _renderPlot: ->
    model = @model
    data = []
    @ui.list.find('input:checked').each ->
      key = $(@).attr('name')
      data.push(model.get('data')[key]) if (key and model.get('data')[key])

    setTimeout(=>
      $.plot(@ui.container, data, @params)
    , 10)

module.exports = OnePlotView
