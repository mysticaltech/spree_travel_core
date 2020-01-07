class CreateSpreeContextOptionValues < ActiveRecord::Migration[4.2]
  def change
    create_table :spree_context_option_values do |t|
      t.integer :context_id
      t.integer :option_value_id
      t.string :value
    end
  end
end
