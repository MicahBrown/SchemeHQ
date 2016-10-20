module ApplicationHelper
  def reveal name, options={}, &block
    css_class = options.has_key?(:class) ? "reveal #{options[:class]}" : "reveal"
    options   = options.deep_merge id:    name,
                                   class: css_class,
                                   data:  { reveal: ''}

    content_tag :div, capture(&block) + close_button, options
  end

  def close_button
    button_tag '&times;'.html_safe, class: 'close-button secondary-text', data: { close: '' }
  end
end
