class CreateSettings < ActiveRecord::Migration
  def self.up
    create_table :settings do |t|
      t.references :user
      t.boolean :automatic, :default => false
      t.decimal :time_digit, :default => 2, :precision =>  6, :scale =>  1
      t.string :time_unit, :default => "hours"
      t.datetime :publish_from
      t.datetime :publish_until
      t.timestamps
    end
  end

  def self.down
    drop_table :settings
  end
end
