class AddDefaultToAdminLevel < ActiveRecord::Migration[7.1]
  def change
      change_column_default :users, :admin_level, 0
  end
end
