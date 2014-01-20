class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :hashed_password, :limit => 40
      t.string :salt, :limit => 40
      t.boolean :admin, :default => false


      t.index :email
      t.timestamps
    end
  end
end
