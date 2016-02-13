window.Views ||= {}

class Views.ApplicationView
  render: ->
    $('.alert .close').click (e) ->
      e.preventDefault()
      $(@).closest('.alert').fadeOut()

  cleanup: ->
    #
