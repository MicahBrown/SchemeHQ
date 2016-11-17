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

  def action_links links, simple=true
    return nil if links.blank?
    links = links.map{|link| content_tag :li, link }.join.html_safe
    content_tag :ul, links, class: "menu#{' simple' if simple}"
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

  def user_display_name user
    return user.display_name if current_nicknames.blank?

    nickname = current_nicknames.detect { |n| n.namee_id == user.id }
    nickname ? nickname.value : user.display_name
  end
end
