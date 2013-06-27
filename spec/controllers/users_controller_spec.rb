require 'spec_helper'

describe UsersController do
 render_views
  
  describe "GET 'show'" do

  	  before(:each) do
  		@user = Factory(:user)
  	  end
 
      it "should be successful" do
  		get :show, :id => @user.id
  		response.should be_success
  	  end

  	  it "should find right user" do
  		get :show, :id => @user
  		assigns(:user).should == @user
  	  end

  	  it "should have right title " do
  	  	get :show, :id => @user
  	  	response.should have_selector('title', :content => @user.name)
  	  end

  	  it "should have the user's name" do
  	  	response.should have_selector('h1', :content => @user.name)
  	  end

  	  it "should have a profile image" do
  	  	get :show, :id =>@user
  	  	response.should have_selector('h1>img', :class => "gravatar")
  	  end

      it "should have right path" do
        get :show, :id =>@user
        response.should have_selector('td>a', :content => user_path(@user),
                                              :href    => user_path(@user))
      end
  	end


    describe "GET 'new'" do
       it "returns http success" do
        get :new
        response.should be_success
       end

       it "should have right title" do
    	get :new
    	response.should have_selector('title', :content => "sign up")
       end
    end
end
