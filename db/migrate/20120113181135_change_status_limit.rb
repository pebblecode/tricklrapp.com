class ChangeStatusLimit < ActiveRecord::Migration
  def up
    change_column :statuses, :status, :string, :null => false
  end
  def down
    change_column :statuses, :status, :string, :null => false, :limit => 140
  end
end
