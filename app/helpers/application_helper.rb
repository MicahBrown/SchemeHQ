module ApplicationHelper
  def reveal name, options={}, &block
    css_class = options.has_key?(:class) ? "reveal #{options[:class]}" : "reveal"

    content_tag :div, capture(&block), options.deep_merge( id:    name,
                                                           class: css_class,
                                                           data:  { reveal: ''} )
  end
end
