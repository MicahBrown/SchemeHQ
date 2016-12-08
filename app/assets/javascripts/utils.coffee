window.updateQueryStringParameter = (uri, key, value) ->
  regex     = new RegExp "([?&])" + key + "=.*?(&|$)", "i"
  separator = if uri.indexOf('?') != -1 then "&" else "?"

  if uri.match regex
    uri.replace(regex, ('$1' + key + "=" + value + '$2'))
  else
    uri + separator + key + "=" + value
