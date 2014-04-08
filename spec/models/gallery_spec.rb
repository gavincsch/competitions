require 'spec_helper'

describe Gallery do

   it  'should validate_uniqueness_of album_name'do
      existing_album_name = FactoryGirl.create(:gallery)
      gallery  =  Gallery.new(:album_name => 'mock_1')
      expect{gallery.save!}.to raise_error(ActiveRecord::RecordInvalid,'Validation failed: Album name has already been taken')
   end

   it  'should pass validate_uniqueness_of album_name'do
     existing_album_name = FactoryGirl.create(:gallery)
     gallery  =  Gallery.new(:album_name => 'mock_2')
     expect{gallery.save!}.to change(Gallery, :count).by(1)
   end


   it  'should validate_presence_of album_name'do
    gallery = Gallery.new(:album_name => '')

    expect{gallery.save!}.to raise_error(ActiveRecord::RecordInvalid,'Validation failed: Album name is required')
   end
end
