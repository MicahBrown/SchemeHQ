window.tabSaver = ->
  # Retrieves tab-specific key for scoping cookies
  cookieKey = ($tabs) ->
    key = $tabs.attr 'id'
    "tabs-" + key

  # Retrieves index for setting current tab
  getTabCookie = ($tabs) ->
      keyValue = document.cookie.match('(^|;) ?' + cookieKey($tabs) + '=([^;]*)(;|$)')
      if keyValue then keyValue[2] else null

  # Saves index of current tab to cookie
  setTabCookie = ($tabs, value) ->
    duration   = 365 * 24 * 60 * 60 * 1000 # 1 year
    expiration = new Date()
    expiration.setTime(expiration.getTime() + duration)
    expiration = expiration.toUTCString()

    document.cookie = cookieKey($tabs) + '=' + value + ';expires=' + expiration + ";path=/"
    true


  # Retrieves the index for current tab when one has been saved
  defaultTabIndex = ($tabs) ->
    return 0 if !$tabs.hasClass('active-tabs')

    $tabs.data('tabs-default') || null

  # Retrieves index of list item that will be activated in tab menu
  newItem = ($tabs) ->
    currentTabIndex = getTabCookie($tabs) || defaultTabIndex($tabs)

    $tabs.children().eq currentTabIndex

  $allTabs = $('.tabs')
  $allTabs.each ->
    $tabs    = $(this)
    $newItem = newItem $tabs
    $newLink = $newItem.children 'a'

    if $tabs.hasClass 'active-tabs'
      $tabs.activeTabs 'activateLink', $newLink
      $tabs.on 'changed.tabs', (event, $currentTabLink) ->
        index = $currentTabLink.parent().index()
        index = if index == -1 then null else index

        setTabCookie $tabs, index
    else
      $tabsContent = $("[data-tabs-content='" + $tabs.attr('id') + "']")
      $newTab      = $tabsContent.find $newLink.attr('href')

      $tabs.foundation 'selectTab', $newTab
      $tabs.on 'change.zf.tabs', (event, $currentTabItem) ->
        index = $currentTabItem.index()

        setTabCookie $tabs, index

    $allTabs

window.activeTabs = ->
  $tabs = $('.active-tabs.tabs')
  $tabs.activeTabs()

window.initializeFoundation = ->
  $(document).foundation();

  activeTabs() if $('.active-tabs').length > 0
  tabSaver()   if $('.tabs').length > 0
