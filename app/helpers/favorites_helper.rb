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
end