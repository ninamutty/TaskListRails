class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uid, null: false
      t.string :name
      t.string :provider, null: false
      t.string :email

      t.timestamps null: false
    end
  end
end
