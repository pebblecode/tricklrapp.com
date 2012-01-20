class AmendSettingsDefaults < ActiveRecord::Migration
  def up
    change_column_default(:settings, :publish_from, '09:00:00')
    change_column_default(:settings, :publish_until, '23:00:00')
  end

  def down
    change_column_default(:settings, :publish_from, nil)
    change_column_default(:settings, :publish_until, nil)
  end
end
