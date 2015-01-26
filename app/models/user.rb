class User < ActiveRecord::Base
  has_many :trades
  has_many :categories

  acts_as_tagger

  validates :provider, presence: true
  validates :uid, presence: true
  validate  :uniqueness_user
  validates :image_url, format: {
    with: /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix, allow_blank: true
  }

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider  = auth[:provider]
      user.uid       = auth[:uid]
      user.nickname  = auth[:info][:nickname]
      user.name      = auth[:info][:name]
      user.image_url = auth[:info][:image]
    end
  end

  def self.find_by_omniauth(auth)
    provider  = auth[:provider]
    uid       = auth[:uid]
    User.find_by(provider: provider, uid: uid)
  end

  def self.find_or_create_by_omniauth(auth)
    User.find_by_omniauth(auth) ||
      User.create_with_omniauth(auth)
  end

  def uniqueness_user
    one = User.find_by(provider: provider, uid: uid)
    if one && one != self
      errors.add(:uniqueness_user, "has already existed #{provider} #{uid}")
    end
  end
end
