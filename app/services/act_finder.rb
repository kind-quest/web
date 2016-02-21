class ActFinder
  def initialize(user)
    @user = user
  end

  def find_acts(n)
    Act.order(created_at: :desc).where.not(id: blacklisted_acts).first(n)
  end

  private

  def blacklisted_acts
    viewed_acts.concat user_owned_acts
  end

  def user_owned_acts
    @user.acts.pluck :id
  end

  def viewed_acts
    @user.act_views.pluck :act_id
  end
end
