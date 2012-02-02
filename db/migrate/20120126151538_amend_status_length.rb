class AmendStatusLength < ActiveRecord::Migration
  def up
    change_column :statuses, :status, :string, :limit => 255
  end

  def down
    change_column :statuses, :status, :string, :limit => 140
  end
end
