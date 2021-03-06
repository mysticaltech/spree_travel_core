module Spree::OptionTypeDecorator
  def self.prepended(base)
    base.validates_uniqueness_of :name
    # base.validates_format_of :name, with: /\A[a-z_]+\z/, message: "can only contains lowercase letters and '_'"
    base.after_create :default_option_value
  end

  def default_option_value
    if attr_type != 'selection' && option_values.empty? && travel == true
      Spree::OptionValue.create(name: self.name,
                                presentation: self.presentation,
                                option_type_id: self.id
       )
    end
  end
end

Spree::OptionType.prepend Spree::OptionTypeDecorator