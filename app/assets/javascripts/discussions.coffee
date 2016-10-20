class Discussion
  pollForm: ->
    $reveal = $("#poll_reveal")
    $reveal.on "click", ".remove-poll-option", (e) ->
      e.preventDefault()

      $(this).closest('li').hide().find(':input').attr 'disabled', 'disabled'
             # .remove() # inadvertantly closes reveal modal
      true

    $reveal.on "click", ".add-poll-option", (e) ->
      e.preventDefault()

      $link        = $(this)
      $pollOptions = $link.siblings '#poll_poll_options'
      fieldHash    = $link.data 'field-hash'
      newId        = new Date().getTime()
      regexp       = new RegExp "new_" + fieldHash.association, "g"

      $pollOptions.append fieldHash.content.replace(regexp, newId)
      true

    $reveal


$(document).on 'discussions_show.load', (e, obj) =>
  discussion = new Discussion
  discussion.pollForm()
