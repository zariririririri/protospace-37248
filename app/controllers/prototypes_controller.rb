class PrototypesController < ApplicationController
  before_action :set_prototype, only:            [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only:       [:new, :edit, :destroy, :create, :update]
  before_action :contributor_confirmation, only: [:edit, :updata, :destroy]

  def index
    @prototypes = Prototype.includes(:user)
   end
  
  def new
    @prototype = Prototype.new
  end
 
 def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :show
    end 
  end
 
  def edit
  end
   
  def update
   if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype)
    else
      render :edit
    end
  end

  def show
    @comment = Comment.new
    @comments = @prototype.comments
  end

 
  def destroy
    if  @prototype.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
  end   
   
private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image ).merge(user_id: current_user.id )
  end

  def contributor_confirmation
    redirect_to root_path unless current_user == @prototype.user
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end
end
  
  

  
  
 

  

