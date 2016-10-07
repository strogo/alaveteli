class AddProFlagToUser < ActiveRecord::Migration
  def change
    add_column :users, :pro, :boolean, default: false, null: false
    add_index :users, :pro
  end
end
