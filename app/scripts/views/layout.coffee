class AppLayout extends Marionette.LayoutView
  el: 'body'

  ui:
    navigation: '.right'
    navElement: '.right li'
    loadFile: '.upload-file'
    file: '#file'
    fileName: '.file-name'

  regions:
    mainRegion: '#main_region'

  events:
    'click @ui.loadFile': 'onClickLoadFile'
    'change @ui.file': 'onUploadFile'

  initialize: ->
    @reader = new FileReader()

    @reader.onload = (event) ->
      localStorage.setItem('data', event.target.result)

    @reader.onerror = (event) ->
      console.error(event.target.error.code)

  initialize: ->
    @bindUIElements()
    fileName = localStorage.getItem('file_name')
    @ui.fileName.html("file \"#{fileName}\" has been uploaded") if fileName

  onClickLoadFile: ->
    @ui.file.trigger('click')

  onUploadFile: (event) ->
    file = event.target.files[0]
    @reader.readAsText(file)
    @ui.fileName.html("file \"#{file.name}\" has been uploaded")
    localStorage.setItem('file_name', file.name)

  setNav: (url) ->
    @ui.navElement.removeClass('active')
    @ui.navigation.find(".js-link[data-url='#{url}']").parent().addClass('active')

module.exports = AppLayout
