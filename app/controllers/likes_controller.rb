class LikesController < ApplicationController
  def create
    @like = Like.new like_params.merge user: current_user

    respond_to do |format|
      if @like.save
       format.json { render @like, status: :created, location: @like }
      else
        format.json { render @like.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def like_params
    params.permit :act_id
  end
end
