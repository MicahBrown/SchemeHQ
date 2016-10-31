class Discussion
  pollForm: ->
    # initialize variables
    $reveal = $("#poll_reveal")

    # assign functions
    renumberOptions = ->
      $list = $reveal.find("#poll_poll_options")
                     .find("li.poll-option-fields:visible")
      count = $list.length

      $reveal.find('.add-poll-option').toggle count < 8

      $list.each (idx) ->
        $(this).find 'input[type="hidden"][name$="[position]"]'
               .val  idx

        $(this).find 'label'
               .text (i, txt) ->
                txt.replace(/\d+/, idx + 1)


    # register events
    $reveal.on "click", ".remove-poll-option", (e) ->
      e.preventDefault()

      $(this).closest('li.poll-option-fields').hide().find(':input').attr 'disabled', 'disabled'
             # .remove() # inadvertantly closes reveal modal

      renumberOptions()
      true

    $reveal.on "click", ".add-poll-option", (e) ->
      e.preventDefault()

      $link        = $(this)
      $pollOptions = $link.siblings '#poll_poll_options'
      fieldHash    = $link.data 'field-hash'
      newId        = new Date().getTime()
      regexp       = new RegExp "new_" + fieldHash.association, "g"

      $pollOptions.append fieldHash.content.replace(regexp, newId)
      renumberOptions()
      true

    $reveal

  commentEditForm: ->
    $(".entries").on "click", ".edit", (e) ->
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


$(document).on 'discussions_show.load', (e, obj) =>
  discussion = new Discussion
  discussion.pollForm()
  discussion.commentEditForm()