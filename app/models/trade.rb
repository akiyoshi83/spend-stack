class Trade < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  acts_as_taggable

  validates :amount,
    presence: true,
    numericality: { only_integer: true }
  validates :trade_at, presence: true
  validates :memo, length: { maximum: 256 }
  validates :user, presence: true
end
