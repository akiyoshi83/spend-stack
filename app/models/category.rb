class Category < ActiveRecord::Base
  belongs_to :user
  has_many :trades

  validates :name, length: { in: 1..128 }
  validates :color, format: { with: /\A#([\da-f]{3}){1,2}\Z/i }

  before_validation :downcase_color

  private

  def downcase_color
    self.color = self.color.downcase if self.color.present?
  end
end
