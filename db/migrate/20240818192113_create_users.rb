class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :user_mail
      t.string :user_password
      t.boolean :is_admin

      t.timestamps
    end
  end
end
