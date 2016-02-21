class ActView < ActiveRecord::Base
  belongs_to :user
  belongs_to :act

  validates :user, presence: true
  validates :act, presence: true
end
