class CreateBranches < ActiveRecord::Migration[5.1]
  def change
    create_table :branches do |t|
      t.string :street
      t.string :city
      t.string :state
      t.string :zipcode
    end
  end
end
