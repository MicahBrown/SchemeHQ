module UsersHelper
  def user_display_name user
    return user.display_name if current_nicknames.blank?

    nickname = current_nicknames.detect { |n| n.namee_id == user.id }
    nickname ? nickname.value : user.display_name
  end

  def user_link user, icon_name=nil, options={}
    options, icon_name = icon_name, nil if icon_name.is_a?(Hash)
    value = content_tag :span, user_display_name(user), class: 'value'
    value = icon(icon_name, value, class: 'fa-fw') if icon_name

    options[:class]   = "user-link #{options[:class]}" if options.key?(:class)
    options[:class] ||= "user-link"

    link_to value, "javascript:void(0);", options.deep_merge({ data: { user: user.to_param } })
  end
end
