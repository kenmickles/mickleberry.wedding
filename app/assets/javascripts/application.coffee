#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require leaflet
#= require bootstrap/collapse
#= require_tree .

$ ->
  $('.alert .close').click (e) ->
    e.preventDefault()
    $(@).closest('.alert').fadeOut()