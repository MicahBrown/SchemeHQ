//= require validator/parsley.main
//= require validator/parsley.locale

var initializeValidator = function(){
  Parsley.options.namespace    = 'data-guard-'
  Parsley.options.errorClass   = 'is-invalid-input'
  Parsley.options.successClass = 'is-valid-input'

  if ( $('[data-guard-validate]')[0] )
    $('[data-guard-validate]').parsley();
}