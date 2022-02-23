class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :store, foreign_key: true
      t.integer :total

      t.timestamps
    end
  end
end
