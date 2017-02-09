class CreateSolidusLiquidAssets < ActiveRecord::Migration
  def change
    create_table :solidus_liquid_assets do |t|
      t.integer :theme_id
      t.string :key
      t.string :file

      t.timestamps null: false
    end
    add_index :solidus_liquid_assets, :theme_id
    add_index :solidus_liquid_assets, :key
  end
end