class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :category
      t.text :text
      t.boolean :is_sent, default: false

      t.timestamps
    end
  end
end
