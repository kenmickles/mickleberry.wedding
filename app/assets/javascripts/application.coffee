#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require leaflet
#= require bootstrap/collapse
#= require_tree .

pageLoad = ->
  className = $('body').data('js-view')
  
  window.applicationView = try
    eval("new #{className}()")
  catch error
    new Views.ApplicationView()
  
  window.applicationView.render()

$ ->
  pageLoad()

  $(document).on 'page:load', pageLoad
  
  $(document).on 'page:before-change', ->
    window.applicationView.cleanup()
    true
  
  $(document).on 'page:restore', ->
    window.applicationView.cleanup()
    pageLoad()
    true