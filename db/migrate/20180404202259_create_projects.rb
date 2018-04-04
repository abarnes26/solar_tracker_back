class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :street
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :customer_name
      t.integer :size_kW
      t.string :solar_data
      t.integer :carbon_impact_lbs
      t.integer :annual_offset
      t.integer :age_days
      t.integer :round_trip_miles
      t.string :status
      t.references :branch, foreign_key: true
    end
  end
end
