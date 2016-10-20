module ApplicationHelper
  def reveal name, options={}, &block
    css_class = options.has_key?(:class) ? "reveal #{options[:class]}" : "reveal"
    options   = options.deep_merge id:    name,
                                   class: css_class,
                                   data:  { reveal: ''}

    content_tag :div, close_button + capture(&block), options
  end

  def close_button
    button_tag '&times;'.html_safe, class: 'close-button secondary-text', data: { close: '' }
  end

  def wrap_content_tag_if(condition, tag=:div, options={}, &block)
    options, tag = tag, :div if tag.is_a?(Hash) && options.blank?

    if condition
      content_tag(tag, capture(&block), options)
    else
      capture(&block)
    end
  end
end
