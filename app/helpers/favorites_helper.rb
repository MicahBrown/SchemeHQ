module FavoritesHelper
  def favorite_link scheme_entry, reload_faves=false
    existing_fave = current_favorites.detect {|fave| fave.scheme_entry_id == scheme_entry.id }
    fave_count    = scheme_entry.favorites(reload_faves).size

    button_to scheme_entry_favorites_path(scheme_entry.scheme, scheme_entry),
      method:     existing_fave ? :delete : :post,
      form_class: "favorite-form",
      class:      "favorite#{' favorited' if existing_fave}" do
      icon("heart", fave_count)
    end
  end
end