require 'spec_helper'

describe UsersController do
 render_views
  
  describe "GET 'show'" do

  	define(:each) do
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
