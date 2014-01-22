class Gallery < ActiveRecord::Base
  has_many :images, :dependent => :destroy
  accepts_nested_attributes_for :images, allow_destroy: false

  validates_presence_of :album_name

end
