class Discussion
  pollForm: ->
    # initialize variables
    $tabs = $("[data-tabs-content='action_tabs']")
    $tab  = $tabs.find "#panel2"

    # assign functions
    renumberOptions = ->
      $list = $tab.find("#poll_poll_options")
                  .find("li.poll-option-fields:visible")
      count = $list.length

      $tab.find('.add-poll-option').toggle count < 8

      $list.each (idx) ->
        $(this).find 'input[type="hidden"][name$="[position]"]'
               .val  idx

        $(this).find 'label'
               .text (i, txt) ->
                txt.replace(/\d+/, idx + 1)


    # register events
    $tab.on "click", ".remove-poll-option", (e) ->
      e.preventDefault()

      $(this).closest('li.poll-option-fields').remove()

      renumberOptions()
      true

    $tab.on "click", ".add-poll-option", (e) ->
      e.preventDefault()

      $link        = $(this)
      $pollOptions = $link.siblings '#poll_poll_options'
      fieldHash    = $link.data 'field-hash'
      newId        = new Date().getTime()
      regexp       = new RegExp "new_" + fieldHash.association, "g"

      $pollOptions.append fieldHash.content.replace(regexp, newId)
      renumberOptions()
      true

    $tab

  commentEditForm: ->
    $(".entries").on "click", ".entry .edit", (e) ->
      e.preventDefault()

      $link  = $(this)
      $entry = $link.closest ".entry"
      $form  = $entry.siblings ".form"

      $entry.hide()

      if $form.length > 0
        $form.show()
      else
        $entry.after "<div class='form'>" + spinner + "</div>"

        path = $link.attr "href"

        $.get path, undefined, undefined,  "script"

    $(".entries").on "click", ".form .cancel", (e) ->
      $form = $(this).closest ".form"
      $entry = $form.siblings ".entry"

      $form.hide()
      $entry.show()

  invitationForm: ->
    $dialog    = $("#invitation_dialog")
    $submit    = $dialog.find 'button.button'
    $textField = $dialog.find '#new_invitee'
    $list      = $dialog.find 'ul.invitations-list'
    validator  = $textField.parsley()

    # Adding an invitation
    $submit.on 'click', (e) ->
      e.preventDefault()
      validator.validate()
      value = $.trim $textField.val()

      if validator.isValid()
        $toolbox = $dialog.find '.toolbox'
        $newRow  = $toolbox.html().split("{ email }").join value

        $list.prepend($newRow).find('.empty').hide()
        $textField.focus().val ''

    # Deleting an invitation
    $list.on 'click', 'a', (e) ->
      e.preventDefault()

      $(this).closest('li')[0].remove()
      $list.find('.empty').show() if $list.children().length < 2

$(document).on 'discussions_show.load', (e, obj) =>
  discussion = new Discussion
  discussion.pollForm()
  discussion.commentEditForm()
  discussion.invitationForm()


window.postInvitationErrors = (jsonString) ->
  errors    = JSON.parse(jsonString)
  $list     = $(".invitations-list")
  $newItems = $list.children(".invitation").filter ".new"

  $.each errors, (invEmail, invErrors) ->
    $item   = $newItems.find("input[value='" + invEmail + "']").closest "li"
    $errors = $("<ul class='errors-ul'></ul>")

    $.each invErrors, (index, error) ->
      $errors.append "<li>" + error + "</li>"

    $item.find ".errors-ul"
         .remove()
    $item.append $errors
