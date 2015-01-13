require 'byebug'
class GoalsController < ApplicationController
  def new
    @goal = Goal.new
    render :new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user = current_user
    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] ||= []
      flash.now[:errors] << @goal.errors.full_messages
      render :new
    end
  end

  def index
    @goals = Goal.all
    render :index
  end

  def show
    @goal = Goal.find(params[:id])
    render :show
  end

  def edit
    @goal = Goal.find(params[:id])
    render :edit
  end

  def update

  end

  def destroy
    @goal = Goal.find(param[:id])
    redirect_to goals_url
  end

  private

  def goal_params
    params.require(:goal).permit(:title, :body, :is_private)
  end
end
