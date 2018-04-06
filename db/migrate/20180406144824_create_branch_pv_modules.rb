class CreateBranchPvModules < ActiveRecord::Migration[5.1]
  def change
    create_table :branch_pv_modules do |t|
      t.references :branch, foreign_key: true
      t.references :pv_module, foreign_key: true
    end
  end
end
