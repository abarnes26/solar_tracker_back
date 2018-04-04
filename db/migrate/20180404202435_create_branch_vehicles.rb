class CreateBranchVehicles < ActiveRecord::Migration[5.1]
  def change
    create_table :branch_vehicles do |t|
      t.references :branch, foreign_key: true
      t.references :vehicle, foreign_key: true
    end
  end
end
