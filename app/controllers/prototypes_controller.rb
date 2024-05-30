class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :move_to_index, except: [:index, :show]

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def show
    begin
      @prototype = Prototype.find(params[:id])
      @user_email = @prototype.user.email
      @comment = Comment.new
      @comments = @prototype.comments.includes(:user)
    rescue ActiveRecord::RecordNotFound
      redirect_to new_user_session_path
    rescue NoMethodError
      redirect_to new_user_session_path
    end
  end

  def create
    @prototype = current_user.prototypes.build(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype)
    else
      render :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image)
  end

  def move_to_index
    if params[:id].present?
      @prototype = Prototype.find(params[:id])
      unless user_signed_in? && @prototype.user == current_user
        redirect_to action: :index
      end
    end
  end
end
