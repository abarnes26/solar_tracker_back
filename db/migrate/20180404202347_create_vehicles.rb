class CreateVehicles < ActiveRecord::Migration[5.1]
  def change
    create_table :vehicles do |t|
      t.string :make
      t.string :model
      t.integer :mpg
      t.references :branch, foreign_key: true
    end
  end
end
