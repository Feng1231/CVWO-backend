class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :token
      t.integer :admin_level

      t.timestamps
    end
  end
end
