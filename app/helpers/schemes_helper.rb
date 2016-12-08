module SchemesHelper
  def schemable_author schemable
    user      = schemable.user
    icon_name = case schemable
                when Comment then 'comment'
                when Poll    then 'bar-chart'
                end

    user_link user, icon_name
  end

  def schemable_actions schemable
    links = case schemable
            when Comment then comment_links(schemable)
            when Poll    then poll_links(schemable)
            end

    return if links.blank?
    action_links links.reverse
  end
end
