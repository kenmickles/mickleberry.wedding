window.Views ||= {}

class Views.ApplicationView
  isElementInViewport = (el) ->
    el = el[0] if el instanceof jQuery
    rect = el.getBoundingClientRect()

    (
      rect.top >= 0 &&
      rect.left >= 0 &&
      rect.bottom <= $(window).height() && 
      rect.right <= $(window).width()
    )

  validateForm = (e) ->
    $form = $(@)
    $form.find('.has-error').removeClass('has-error')
    $form.find('.form-error').remove()

    $form.find(':input[required]').each (i, input) ->
      $input = $(input)
      $formGroup = $input.closest('.form-group')

      # missing radio selection
      if $input.attr('type') == 'radio' && $formGroup.find("input[name='#{$input.attr('name')}']:checked").length == 0 && !$formGroup.hasClass('has-error')
        $formGroup.addClass('has-error')
        $formGroup.find('.radio:first').before("<div class='help-block form-error'>Please select one</div>")

      # other missing fields
      else if $.trim($input.val()) == ''
        $formGroup.addClass('has-error')
        $input.after("<div class='help-block form-error'>Please fill this in</div>")
        $input.focus()

    if $form.find('.form-error').length > 0
      $el = $form.find('.form-error:first')

      if !isElementInViewport($el)
        $('html, body').animate({
          scrollTop: $el.offset().top - 200
        }, 200)

      return false


  render: ->
    $('.alert .close').click (e) ->
      e.preventDefault()
      $(@).closest('.alert').fadeOut()

    $('form').submit(validateForm)


  cleanup: ->
    #
