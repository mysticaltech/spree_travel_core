module Spree
  class Context < Spree::Base

    include PersistedDynamicAttribute
    include TemporalDynamicAttribute

    has_many :line_items, class_name: 'Spree::LineItem',
                          foreign_key:'context_id'
    has_many :option_values, class_name: 'Spree::ContextOptionValue',
                             foreign_key: 'context_id',
                             dependent: :destroy

    def initialize_variables
      @temporal = {}
    end

    def get_temporal
      @temporal
    end

    def self.build_from_params(params, options = {})
      raise StandardError.new("You must be explicit about temporal or not") if options[:temporal].nil?
      context = if !options[:line_item_id].nil?
                  Spree::LineItem.find(options[:line_item_id]).context
                else
                  Spree::Context.new
                end

      context.initialize_variables
      context_params = context.option_types_and_values_from_params(params)
      if options[:temporal]
        context.set_temporal_option_values(context_params)
      else
        context.set_persisted_option_values(context_params)
        context.save
      end
      return context
    end

    def product_type(options = {temporal: true})
      get_mixed_option_value(:product_type, options)
    end

    def start_date(options = {temporal: true})
      get_mixed_option_value(:start_date, options)
    end

    def end_date(options = {temporal: true})
      get_mixed_option_value(:end_date, options)
    end

    def plan(options = {temporal: true})
      get_mixed_option_value(:plan, options)
    end

    def adult(options = {temporal: true})
      get_mixed_option_value(:adult, options)
    end

    def child(options = {temporal: true})
      get_mixed_option_value(:child, options)
    end

    #this is for the amount of rooms
    def room_count(options = {temporal: true})
      get_mixed_option_value(:room_count, options)
    end

    def cabin_count(options = {temporal: true})
      get_mixed_option_value(:cabin_count, options)
    end

    #this is for the room type (Sweet, Junio Sweet, etc.....)
    def room(options = {temporal: true})
      get_mixed_option_value(:room, options)
    end

    def departure_date(options = {temporal: true})
      get_mixed_option_value(:departure_date, options)
    end

    def category(options = {temporal: true})
      get_mixed_option_value(:category, options)
    end

    def pickup_destination(options = {temporal: true})
      get_mixed_option_value(:pickup_destination, options)
    end   
    
    def return_destination(options = {temporal: true})
      get_mixed_option_value(:return_destination, options)
    end

    def pickup_date(options = {temporal: true})
      get_mixed_option_value(:pickup_date, options)
    end

    def return_date(options = {temporal: true})
      get_mixed_option_value(:return_date, options)
    end

    def find_existing_option_value(option_type)
      option_values.find { |ov| ov.option_value_id.present? && ov.option_value.option_type_id == option_type.id }
    end
  end
end
