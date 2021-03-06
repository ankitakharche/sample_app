class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update]
  before_filter :correct_user, :only => [:edit, :update]

  def index
    @users = user.all
    @title = "All users"
  end

  def show
  	@user = User.find(params[:id])
  	@title = @user.name
  end

  def new
  	@user  = User.new
  	@title = "sign up"
  end

  def create
    @user = User.new(params[:user])
  	if @user.save
      sign_in @user
  		redirect_to @user, :flash => { :success => "Welcome to the Sample App!"} 
    else
      @title = "Sign up"
  	  render 'new'
  	end
  end

  def edit
    @user = User.find(params[:id])
    @title = "Edit user"
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end

  private 

    def authenticate
     deny_access unless signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
end
