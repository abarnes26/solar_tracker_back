class CreateProjectVehicles < ActiveRecord::Migration[5.1]
  def change
    create_table :project_vehicles do |t|
      t.references :project, foreign_key: true
      t.references :vehicle, foreign_key: true
    end
  end
end
