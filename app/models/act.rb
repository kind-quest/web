class Act < ActiveRecord::Base
  belongs_to :user
  has_many :likes

  validates :user, presence: true
  validates :description, presence: true, if: 'image.blank?'

  has_attached_file :image, styles: { medium: '600x' }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_attachment_presence :image, if: 'description.blank?'
end
