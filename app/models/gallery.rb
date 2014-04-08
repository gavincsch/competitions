class Gallery < ActiveRecord::Base
  has_many :images, :dependent => :destroy


  validates_presence_of :album_name, :message => 'is required'
  validates_uniqueness_of  :album_name, :message => 'has already been taken'

end
