class Competition < ActiveRecord::Base
  has_many :entries

  validates :campaign,    :presence => true, :uniqueness => true
  validates :date_from,   :presence => true
  validates :date_to,     :presence => true
  #validates :enter_image, :presence => true

  before_create     :make_it_permalink
  before_update     :make_it_permalink
  before_validation :set_campaign_url, :only => :campaign_url
  after_validation  :validateActive

  def make_it_permalink
    self.campaign_url
  end

  def set_campaign_url
    self.campaign_url = self.campaign
    if(self.campaign_url[' '])
      self.campaign_url.tr!(' ', '_').downcase
    else
      self.campaign_url.downcase
    end
  end

  def validateActive
      unless self.enter_image?
        errors.add(:active, 'All fields need to be completed to make this competition active')
      end
  end

end
