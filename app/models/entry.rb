class Entry < ActiveRecord::Base
  belongs_to :competition, foreign_key: :competition_id, counter_cache: :entries

  validates_presence_of :firstname
=begin
  validates_presence_of [:dob, :email, :firstname, :mobile, :region, :surname],
                          :message => "is required"
  validates :email, :format => { :with => /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/, :message => 'address is invalid' }
  validates_numericality_of :mobile
  validates_uniqueness_of :email, :case_sensitive => false , :message => "address used"
  validates_uniqueness_of :mobile, :message => "number used"
  validates :q1, :inclusion => {:in => [true, false]}
  validates :q2, :inclusion => {:in => [true, false]}
=end

end
