class CreateStatuses < ActiveRecord::Migration
  def self.up
    create_table(:statuses) do |t|
      t.integer :user_id
      t.string :status, :limit => 140, :null => false
      t.string :twitter_id
      t.string :response_code
      t.datetime :scheduled_at
      t.datetime :published_at
      t.timestamps
    end    
  end

  def self.down
    drop_table :statuses
  end
end
