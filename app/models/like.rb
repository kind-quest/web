class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :act

  validates :user, presence: true
  validates :act, presence: true
  validate :no_previous_like_by_user, if: :new_record?

  private

  def no_previous_like_by_user
    return if act.likes.none? { |like| like.user.id == user.id }
    errors.add :user, 'must not have already like act'
  end
end
