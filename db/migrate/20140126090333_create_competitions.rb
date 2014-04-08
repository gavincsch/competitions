class CreateCompetitions < ActiveRecord::Migration
  def change
    create_table :competitions do |t|
      t.string    :campaign
      t.string    :campaign_url
      t.datetime  :date_from
      t.datetime  :date_to
      t.string    :enter_image
      t.string    :thankyou_image
      t.boolean   :birthday
      t.boolean   :likes_sports
      t.boolean   :has_kids
      t.integer   :entries, :default => 0

      t.timestamps
    end
  end
end
