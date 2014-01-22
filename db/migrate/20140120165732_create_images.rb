class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
        t.string    :images
        t.string    :image_name
        t.integer   :fk_gallery_id
        t.index     :image_name

      t.timestamps
    end
  end
end
