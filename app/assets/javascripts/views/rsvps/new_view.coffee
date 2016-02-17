window.Views.Rsvps ||= {}

class Views.Rsvps.NewView extends Views.ApplicationView
  attendingChanged = ->
    isVisible = $('#rsvp_attending').val() == 'false'
    $('.rsvp-message').toggle(isVisible)

  render: ->
    super()

    $('#rsvp_attending').change(attendingChanged)
    attendingChanged()