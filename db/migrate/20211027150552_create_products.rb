class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :unit
      t.integer :total_quantity
      t.decimal :price
      t.string :category
      t.references :user

      t.timestamps
    end
  end
end
