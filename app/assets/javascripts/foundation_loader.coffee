window.activeTabs = ->
  $tabs = $('.active-tabs.tabs')
  $tabs.activeTabs()

window.initializeFoundation = ->
  $(document).foundation();

  activeTabs() if $('.active-tabs').length > 0
