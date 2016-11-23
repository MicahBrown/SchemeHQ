class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def trim_whitespace *attr_keys
    attr_keys.map do |attr_sym|
      value = send(attr_sym)
      value = value.strip if value.is_a?(String)

      write_attribute(attr_sym, value)
    end
  end

  def downcase *attr_keys
    attr_keys.map do |attr_sym|
      value = send(attr_sym)
      value = value.downcase if value.is_a?(String)

      write_attribute(attr_sym, value)
    end
  end
end
