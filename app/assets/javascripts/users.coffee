window.initializeUserLinks = ->
  loadProfile = (id) ->
    $dialog = getDialog id

    return false if $dialog.hasClass 'loading'

    $dialog.addClass 'loading'
           .html spinner + "<div></div>" # add empty div so spinner isn't last element

    $.get '/users/' + id, (response) ->
      $dialog.html response
      $dialog.removeClass 'loading'


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


  $(".user-link").off("click").on "click", (e) ->
    e.preventDefault()

    $link = $(this)
    id    = $link.data 'user'

    openDialog id

