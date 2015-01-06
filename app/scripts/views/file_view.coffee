ReqRes = require('scripts/facades/reqres')
template = require('templates/form')

class FileView extends Marionette.ItemView
  DATA = {}

  template: template

  ui:
    loadFile: '.load-file'
    file: '#file'
    fileName: '.file-name'

  events:
    'click @ui.loadFile': 'onClickLoadFile'
    'change @ui.file': 'onUploadFile'

  initialize: ->
    ReqRes.setHandler 'get:data', @onGetData

    @reader = new FileReader()

    @reader.onload = (event) =>
      DATA = JSON.parse(event.target.result)

    @reader.onerror = (event) =>
      console.error(event.target.error.code)

  onClickLoadFile: ->
    @ui.file.trigger('click')

  onUploadFile: (event) ->
    file = event.target.files[0]
    @reader.readAsText(file)
    @ui.fileName.html("\"#{file.name}\" has been uploaded")

  onGetData: ->
    DATA

module.exports = FileView
