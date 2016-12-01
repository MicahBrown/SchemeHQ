require 'active_support/concern'

module Schemable
  extend ActiveSupport::Concern

  included do
    has_one :entry, as: :schemable, dependent: :destroy

    before_create :link_to_scheme
  end

  def link_to_scheme
    return false unless scheme.is_a?(Scheme)

    build_entry scheme: scheme
  end
end