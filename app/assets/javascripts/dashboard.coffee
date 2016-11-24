class Dashboard
  # Saves selected tab in a cookie so user can leave and return to the page with their tab saved
  tabs: ->
    $tabs        = $("#dashboard-tabs")
    $tabsContent = $("[data-tabs-content='" + $tabs.attr('id') + "']")
    cookieKey    = 'scheme_dashboard'

    _getTabCookie = ->
      keyValue = document.cookie.match('(^|;) ?' + cookieKey + '=([^;]*)(;|$)')
      if keyValue then keyValue[2] else null

    _setTabCookie = (value) ->
      duration   = 365 * 24 * 60 * 60 * 1000
      expiration = new Date()
      expiration.setTime(expiration.getTime() + duration)
      expiration = expiration.toUTCString()

      document.cookie = cookieKey + '=' + value + ';expires=' + expiration + ";path=/"
      true

    _currentTab = ->
      currentTabIndex = _getTabCookie() || 0
      $tabsContent.children().eq currentTabIndex

    $tabs.foundation 'selectTab', _currentTab()
    $tabs.on 'change.zf.tabs', (event, $currentTabItem) ->
      index = $currentTabItem.index()

      _setTabCookie index


$(document).on 'dashboard_show.load', (e, obj) =>
  dashboard = new Dashboard
  dashboard.tabs()
