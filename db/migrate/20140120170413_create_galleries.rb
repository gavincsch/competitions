class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.string :album_name
      t.integer :image_count
      t.index :album_name

      t.timestamps
    end
  end
end
