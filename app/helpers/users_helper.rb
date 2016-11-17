module UsersHelper
  def user_display_name user
    return user.display_name if current_nicknames.blank?

    nickname = current_nicknames.detect { |n| n.namee_id == user.id }
    nickname ? nickname.value : user.display_name
  end

  def user_link user, value=nil, options={}
    options, value = value, nil if value.is_a?(Hash)
    value ||= user_display_name(user)

    options[:class]   = "user-link #{options[:class]}" if options.key?(:class)
    options[:class] ||= "user-link"

    link_to value, "javascript:void(0);", options.deep_merge({ data: { user: user.to_param } })
  end
end
