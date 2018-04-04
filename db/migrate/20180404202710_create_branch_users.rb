class CreateBranchUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :branch_users do |t|
      t.references :branch, foreign_key: true
      t.references :user, foreign_key: true
    end
  end
end
