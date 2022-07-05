class ReservesController < ApplicationController
  
  before_action :set_current_user
  before_action :authenticate_user

  def index
    @reserves = Reserve.where(user_id: session[:id])
    
  end

  def new
    @reserve = Reserve.new
    @user = User.find(session[:id])
    @room = Room.find(params[:room_id])
    if params[:start_day].empty? || params[:end_day].empty?
      flash[:error] = "日付を入力してください"
      redirect_to room_path(@room)
    
    elsif params[:number_of_people].to_s !~ /^[0-9]+$/
      flash[:error] = "人数を半角数字で入力してください"
      redirect_to room_path(@room)
    end
    
  end

  def create
    @reserve = Reserve.new(reserve_params)
    if @reserve.save
      flash[:notice] ="予約が完了しました"
      redirect_to user_path(session[:id])
    else
      redirect_to controller: :home, action: :top
    end
  end

  private
  def reserve_params
    params.require(:reserve).permit(:start_day, :end_day, :number_of_people, :user_id, :room_id)
  end
end


