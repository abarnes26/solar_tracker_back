class CreatePvModules < ActiveRecord::Migration[5.1]
  def change
    create_table :pv_modules do |t|
      t.integer :output_w
      t.float :efficiency
      t.string :manufacturer
      t.string :model
      t.integer :width_mm
      t.integer :length_mm
    end
  end
end
