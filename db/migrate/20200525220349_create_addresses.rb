class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :line_1
      t.string :line_2
      t.string :city
      t.string :postal_code
      t.references :user, null: false, foreign_key: true
      t.references :province, null: false, foreign_key: true
      t.timestamps
    end
  end
end
