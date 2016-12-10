module FavoritesHelper
  def favorite_link entry, reload_faves=false
    existing_fave = current_favorites.detect {|fave| fave.entry_id == entry.id }
    fave_count    = entry.favorites(reload_faves).size

    button_to scheme_entry_favorites_path(entry.scheme, entry),
      method:     existing_fave ? :delete : :post,
      form_class: "favorite-form",
      class:      "favorite#{' favorited' if existing_fave}" do
      icon("heart", fave_count)
    end
  end

  def fave_action_links fave
    entry = fave.entry
    links = []

    if scheme = fave.entry.try(:scheme)
      links.push link_to(icon("align-left", "Show In Context"), scheme_path(scheme, entry_id: entry.to_param, anchor: entry.tag))
    end

    links.push link_to(icon("heart", "Remove Favorite"), scheme_entry_favorites_path(entry.scheme, entry), method: :delete, data: { disable_with: "Removing...", confirm: "Are you sure?" })

    action_links links
  end
end