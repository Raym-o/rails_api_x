class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :status
      t.decimal :price
      t.decimal :gst
      t.decimal :pst
      t.decimal :hst
      t.references :user, null: false, foreign_key: true
      t.string :stripe_id

      t.timestamps
    end
  end
end
