class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :firstname
      t.string :surname
      t.string :email
      t.integer :mobile
      t.string :region
      t.date :dob
      t.integer :gender
      t.boolean :newsletter, :default => false
      t.string  :source
      t.boolean :q1, :default => false
      t.boolean :q2, :default => false
      t.integer :competition_id

      t.timestamps
    end
  end
end
