class AppLayout extends Marionette.LayoutView
  el: 'body'

  ui:
    navigation: '.right'
    navElement: '.right li'

  regions:
    mainRegion: '#main_region'

  setNav: (url) ->
    @bindUIElements()
    @ui.navElement.removeClass('active')
    @ui.navigation.find(".js-link[data-url='#{url}']").parent().addClass('active')

module.exports = AppLayout
