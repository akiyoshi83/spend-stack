class User < ActiveRecord::Base
  has_many :trades
  has_many :categories

  acts_as_tagger

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
end
