window.activeTabs = ->
  $tabs    = $('.active-tabs.tabs')
  $content = $('.tabs-content[data-tabs-content="' + $tabs.attr('id') + '"]')
  $current = $tabs.find '[aria-selected=true]'

  hideTab = ($link) ->
    $tab = $content.find $link.attr('href')
    $tab.removeClass 'is-active'
        .attr 'aria-hidden', true

  showTab = ($link) ->
    $tab = $content.find $link.attr('href')
    $tab.addClass 'is-active'
        .attr 'aria-hidden', false

  activate = ($link) ->
    $current = $link
    $link.attr 'aria-selected', true

    showTab $link

  deactivate = ($link) ->
    $current = null
    $link.attr 'aria-selected', false

    hideTab $link

  initialize = ->
    $tabs.find('a').each ->
      $link = $(this)
      id    = $link.attr('href').substring(1)

      $link.attr 'role', 'tab'
           .attr 'aria-controls', id

      $link.attr('id', id + '-label')    if $link.attr('id') == undefined
      $link.attr('aria-selected', false) if $link.attr('aria-selected') == undefined

    $content.find('.tabs-panel').each ->
      $tab = $(this)
      id   = $tab.attr 'id'

      $tab.attr 'role', 'tabpanel'
          .attr 'aria-labelledby', id + '-label'

      $tab.attr('aria-hidden', false) if $tab.attr('aria-hidden') == undefined

  $tabs.on 'click', 'a', (e) ->
    e.preventDefault()
    $new = $(this)
    $old = $current

    deactivate($old) if $old
    activate($new)   if !$old || $new.attr('id') != $old.attr('id')


  initialize()