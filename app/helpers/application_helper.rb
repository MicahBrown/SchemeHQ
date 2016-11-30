module ApplicationHelper
  def reveal dialog_name, partial_name=nil, options={}, &block
    options, partial_name = partial_name, nil if partial_name.is_a?(Hash)

    content   = capture(&block) if block_given?
    content ||= render(partial_name) if partial_name.present?

    css_class = options.has_key?(:class) ? "reveal #{options[:class]}" : "reveal"
    options   = options.deep_merge id:    dialog_name,
                                   class: css_class,
                                   data:  { reveal: ''}

    content_tag :div, close_button + content, options
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

  def form_errors object, options={}
    return unless object.present?
    errors = case object
             when ActiveRecord::Base then object.errors.full_messages
             when String             then Array(object)
             when Array              then object
             else
               return
             end
    return unless errors.present?

    message   = options[:message]
    message ||= I18n.t("errors.messages.not_saved", count: errors.size, resource: object.class.model_name.human.downcase) if object.is_a?(ActiveRecord::Base)
    message ||= "Please fix the following and try again:"

    render 'shared/form_errors', errors: errors, message: message
  end

  def flash_message flash
    icon_name = case flash.first
                when "notice" then "check"
                when "alert"  then "warning"
                end

    content_tag :p, icon(icon_name, flash.last), class: 'message'
  end

  def timestamp object
    value = time_ago_in_words(object.updated_at) + " ago"
    value = value.gsub "about ", ""

    content_tag :time, value, title: object.updated_at.strftime("%b %-e, %Y %-I:%M %p %Z"), data: { tooltip: true }
  end

  def header_menu_link icon_name, value, path, options={}
    if current_page?(path)
      options[:class] = options.key?(:class) ? "#{options[:class]} active" : "active"
    end

    link_to icon(icon_name, value), path, options
  end
end
