# A class-based template for jQuery plugins in Coffeescript
#
#     $('.target').activeTabs({ paramA: 'not-foo' });
#     $('.target').activeTabs('myMethod', 'Hello, world');
#
# Check out Alan Hogan's original jQuery plugin template:
# https://github.com/alanhogan/Coffeescript-jQuery-Plugin-Template
#
(($, window) ->

  # Define the plugin class
  class ActiveTabs

    defaults:
      default: null

    constructor: (el, options) ->
      @options      = $.extend({}, @defaults, options)
      @$tabs        = $(el)
      @key          = @$tabs.attr('id')
      @$tabsContent = $(".tabs-content[data-tabs-content='" + @key + "']")
      self          = this

      @$tabs.on 'click', 'a', (event) ->
        event.preventDefault()

        self.activateLink(this)

      self.initialize()

    # Additional plugin methods go here
    initialize: ->
      @$tabs.children().each ->
        $listItem = $(this)
        $link     = $listItem.find 'a'
        $listItem.attr 'role', 'presentation'

        if $link.length > 0
          key = $link.attr    'href'
                     .replace '#', ''

          $link.attr 'id',            key + '-label'
               .attr 'aria-controls', key
               .attr 'role',          'tab'
               .attr 'aria-selected', false

      @$tabsContent.children().each ->
        $content = $(this)
        key      = $content.attr 'id'

        $content.attr 'role',           'tabpanel'
                .attr 'aria-hidden',     true
                .attr 'aria-labelledby', key + '-label'

    getTab: ($link) ->
      tabKey = $link.attr 'href'

      @$tabsContent.find tabKey

    getCurrent: ->
      @$tabs.find 'a[aria-selected="true"]'

    deactivateTab: ($link) ->
      return false if $link.length < 1
      $tab = this.getTab $link

      $tab.removeClass 'is-active'
          .attr        'aria-hidden', true
      $link.attr       'aria-selected', false
      true

    activateTab: ($link) ->
      return false if $link.length < 1
      $tab = this.getTab $link

      $tab.addClass 'is-active'
          .attr     'aria-hidden', false
      $link.attr    'aria-selected', true
      true


    activateLink: (link) ->
      $newLink    = $(link)
      $oldLink    = getCurrent()
      activateNew = $newLink.attr('id') != $oldLink.attr('id')

      changed = false
      changed = true if this.deactivateTab $oldLink
      changed = true if activateNew and this.activateTab($newLink)

      @$tabs.trigger 'changed.tabs'
      changed


  # Define the plugin
  $.fn.extend activeTabs: (option, args...) ->
    @each ->
      $this = $(this)
      data  = $this.data 'tabs'

      if !data
        $this.data 'tabs', (data = new ActiveTabs(this, option))
      if typeof option == 'string'
        data[option].apply data, args

) window.jQuery, window