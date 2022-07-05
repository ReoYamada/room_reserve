class RoomsController < ApplicationController

  before_action :set_current_user, {only:[:new, :create,:edit, :update]}
  before_action :authenticate_user, {only: [:edit, :update]}
  before_action :set_current_room, {only: [:show, :edit]}
  before_action :ensure_correct_room, {only: [:edit, :update]}

  def index
    @rooms = Room.where(user_id: session[:id])
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      flash[:notice] = "ルームを登録しました"
      redirect_to user_path(@user)
    else
      flash[:error_message] = @room.errors.full_messages
      flash[:name] = @room.name
      flash[:introduction] = @room.introduction
      flash[:price] = @room.price
      flash[:address] = @room.address
      redirect_to new_room_path
    end
  end

  def show
  end

  def edit
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      flash[:notice] = "編集しました"
      redirect_to room_path(@room)
    else
      render "edit"
    end
  end

  def destroy
    
  end

  def search
    if params[:erea_search].present?
      @rooms = Room.erea(params[:erea_search])
    elsif params[:keyword_search].present?
      @rooms = Room.keyword(params[:keyword_search])
    else
      @rooms = Room.all
      @all = "all"
    end
  end

  private
  def room_params
    params.require(:room).permit(:name, :introduction, :price, :address, :room_image, :user_id)
  end

end
