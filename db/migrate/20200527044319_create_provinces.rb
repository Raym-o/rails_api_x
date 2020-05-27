class CreateProvinces < ActiveRecord::Migration[6.0]
  def change
    create_table :provinces do |t|
      t.string :name
      t.string :abbr
      t.decimal :pst_rate
      t.decimal :hst_rate
      t.referenced :address

      t.timestamps
    end
  end
end
