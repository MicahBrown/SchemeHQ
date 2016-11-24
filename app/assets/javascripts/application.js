// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require turbolinks
//= require validator/parsley
//= require_tree .

var spinner = "<div class='spinner'>Loading...</div>";

var loadJavascript = function(controller, action){
  $.event.trigger( controller + ".load");
  $.event.trigger( controller + "_" + action + ".load" );
}

var initializePage = function(){
  var controller  = $('body').data('controller'),
      action      = $('body').data('action'),
      initialized = $('body').hasClass('js-initialized');

  if ( initialized )
    return false;

  initializeValidator();
  initializeFoundation()
  loadJavascript(controller, action);
  userLinks();

  $('body').addClass('js-initialized');

  return true;
}

$(document).bind('turbolinks:load', function(){
  initializePage();
});

$(document).ready(function(){
  initializePage();
});