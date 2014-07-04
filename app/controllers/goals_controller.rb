class GoalsController < ApplicationController
  before_action :authorize
  
  def index
    @goals = current_user.goals
  end
  
  def new
    @goal = Goal.new
  end
  
  def create
    @goal = current_user.goals.new(goal_params)
    if @goal.save
      redirect_to @goal
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end
  
  def show
    @goal = Goal.find(params[:id])
  end
  
  def edit
    @goal = Goal.find(params[:id])
  end
  
  def update
    @goal = Goal.find(params[:id])
    if @goal.update_attributes(goal_params)
      redirect_to @goal
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end
  
  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    redirect_to goals_url
  end
  
  def completed
    @goals = current_user.goals.where('goals.status = ?', 'COMPLETE')
  end
  
  def incomplete
    @goals = current_user.goals.where('goals.status = ?', 'INCOMPLETE')
  end
  
  private
  
  def goal_params
    params.require(:goal).permit(:title,:status,:private)
  end
end