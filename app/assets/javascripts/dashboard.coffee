class Dashboard
  invitationResponseForm: ->
    $('#scheme_invitations').on 'submit', '.invitation-response-form', (event) ->
      event.preventDefault()
      $form = $(this)
      path  = $form.attr 'action'

      return false if $form.hasClass 'submitting'
      $('.invitation-response-form[action="' + path + '"]').addClass 'submitting'

      $.post path, $form.serialize(), null, 'script'


$(document).on 'dashboard_show.load', (e, obj) =>
  dashboard = new Dashboard
  dashboard.invitationResponseForm()
