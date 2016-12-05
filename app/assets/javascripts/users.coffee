window.userLinks = (method, opt_id) ->
  initializeProfile = (id) ->
    $dialog      = getDialog id
    $formWrapper = $dialog.find '.nickname-form, .display-name-form'
    $form        = $formWrapper.find 'form'

    setValidator $form

    $dialog.find '.menu'
           .find '.nickname-edit-link, .nickname-add-link, .display-name-link'
           .on "click", (e) ->
      e.preventDefault()
      $formWrapper.toggle()

    $dialog.find '.menu'
           .find '.nickname-delete-link'
           .on "click", (e) ->
      e.preventDefault()

      return false if $dialog.hasClass 'deleting'
      $dialog.addClass 'deleting'

      $link = $(this)
      $.ajax
        url:    $link.attr 'href'
        method: 'DELETE'
        success: ->
          $dialog.removeClass 'deleting'

      false # must return false for link behavior to be prevented


    $form.on 'submit', (e) ->
      e.preventDefault()
      values = $form.serialize()

      return false if $dialog.hasClass 'submitting'

      $dialog.addClass 'submitting'
      $.post $form.attr('action'), values, (response) ->
        $dialog.removeClass 'submitting'


  loadProfile = (id) ->
    $dialog = getDialog id

    return false if $dialog.hasClass 'loading'

    $dialog.addClass 'loading'
           .html spinner + "<div></div>" # add empty div so spinner isn't last element

    $.get '/users/' + id, (response) ->
      $dialog.html response
      $dialog.removeClass 'loading'

      initializeProfile id


  getDialog = (id) ->
    $(".user-profile[data-user='" + id + "']")

  buildDialog = (id) ->
    $('body').append("<div class='reveal user-profile' data-user='" + id + "'></div>")

    new Foundation.Reveal $dialog = getDialog(id)
    $dialog

  openDialog = (id) ->
    $dialog = getDialog id
    $dialog = buildDialog(id) if $dialog.length < 1
    $dialog.foundation 'open'

    loadProfile(id) if $dialog.find('.profile').length < 1
    $dialog

  initialize = ->
    $(".user-link").off("click").on "click", (e) ->
      e.preventDefault()

      $link = $(this)
      id    = $link.data 'user'

      openDialog id


  if method == 'initializeProfile'
    initializeProfile(opt_id)
  else
    initialize()