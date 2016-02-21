class ActsController < ApplicationController
  before_action :authenticate_user!

  def index
    Act.transaction do
      # Find acts to render
      actFinder = ::ActFinder.new current_user
      @acts = actFinder.find_acts(10)

      # If there are no issues, mark these acts as seen
      @acts.each { |act| ::ActView.create! act: act, user: current_user }

      respond_to do |format|
        format.html
        format.json
      end
    end
  end

  def new
    @act = Act.new user: current_user
  end

  def create
    @act = Act.new act_params

    respond_to do |format|
      if @act.save
        format.html { redirect_to @act, notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @act }
      else
        format.html { render :new }
        format.json { render json: @act.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def act_params
    params.permit :description, :image, :user
  end
end
