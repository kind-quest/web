class Act < ActiveRecord::Base
  belongs_to :user
  has_many :likes

  validates :user, presence: true
end
