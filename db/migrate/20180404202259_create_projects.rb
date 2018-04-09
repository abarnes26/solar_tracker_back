class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :street
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :customer_name
      t.float :size_kW
      t.integer :number_of_pv_modules
      t.float :local_annual_irradiance
      t.float :local_carbon_g_per_kWh
      t.float :system_carbon_g_per_kWh
      t.float :total_system_carbon_impact_g
      t.float :annual_production_kWh
      t.integer :age_days, :default => 1
      t.float :round_trip_miles
      t.string :status, :default => 'active'
      t.references :branch, foreign_key: true
      t.references :pv_module, foreign_key: true
    end
  end
end
