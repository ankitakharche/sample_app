require 'spec_helper'

  describe UsersController do
  
    render_views

    describe "GET 'index'" do
      describe "for non-signed-in users" do
        it "should deny access" do
        get :index
        response.should redirect_to(signin_path)
        flash[:notice].should =~ /sign in/i
      end
    end

    describe "for signed-in users" do
      before(:each) do
        @user = test_sign_in(Factory(:user))
        Factory(:user => "bob", :email => "another@example.com")
        Factory(:user => "ben", :email => "another@example.net")
      end

      it "should be successful" do
        get :index
        response.should be_success
      end

      it "should have the right title" do
        get :index
        response.should have_selector("title", :content => "All users")
      end

      it "should have an element for each user" do
        get :index
        @users.each do |user|
          response.should have_selector("li", :content => user.name)
        end
      end
    end

    describe "GET 'show'" do
    
    before(:each) do
      @user = Factory(:user)
    end
  
    it "should be successful" do
      get :show, :id => @user
      response.should be_success
    end
    
    it "should find the right user" do
      get :show, :id => @user
      assigns(:user).should == @user
    end
    
    it "should have the right title" do
      get :show, :id => @user
      response.should have_selector('title', :content => @user.name)
    end
    
    it "should have the user's name" do
      get :show, :id => @user
      response.should have_selector('h1', :content => @user.name)
    end
    
    it "should have a profile image" do
      get :show, :id => @user
      response.should have_selector('h1>img', :class => "gravatar")
    end
    
    it "should have the right URL" do
      get :show, :id => @user
      response.should have_selector('td>a', :content => user_path(@user),
                                            :href => user_path(@user))
    end


    describe "GET 'new'" do
  
     it "should be successful" do
       get :new
       response.should be_success
      end
    
      it "should have the right title" do
        get :new
        response.should have_selector('title', :content => "Sign up")
      end
    end
  

    describe "POST 'create'" do

    describe "failure" do
      
      before(:each) do
        @attr = { :name => "", :email => "", :password => "",
                  :password_confirmation => "" }
      end
      
      it "should have the right title" do
        post :create, :user => @attr
        response.should have_selector('title', :content => "Sign up")
      end

      it "should render the 'new' page" do
        post :create, :user => @attr
        response.should render_template('new')
      end

      it "should not create a user" do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end
    end



    describe "success" do

      before(:each) do
        @attr = { :name => "New User", :email => "user@example.com",
                  :password => "foobar", :password_confirmation => "foobar" }
      end

      it "should create a user" do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end
      
      it "should redirect to the user show page" do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
      end

      it "should have a welcome message" do
        post :create, :user => @attr
        flash[:success].should =~ /welcome to the sample app/i
      end
    end

    describe "GET 'edit'" do
      before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
      end
      it "should be successful" do
        get :edit, :id => @user
        response.should be_success
      end
      it "should have the right title" do
        get :edit, :id => @user
        response.should have_selector("title", :content => "Edit user")
      end
      it "should have a link to change the Gravatar" do
        get :edit, :id => @user
        gravatar_url = "http://gravatar.com/emails"
        response.should have_selector("a", :href => gravatar_url,
                                           :content => "change")
      end
    end

    describe "PUT 'update'" do
      before(:each) do
        @user = Factory(:user)
        test_sign_in(@user)
      end
        describe "failure" do
          before(:each) do
            @attr = { :email => "", :name => "", :password => "",
                                                 :password_confirmation => "" }
          end
          it "should render the 'edit' page" do
            put :update, :id => @user, :user => @attr
            response.should render_template('edit')
          end
          it "should have the right title" do
            put :update, :id => @user, :user => @attr
            response.should have_selector("title", :content => "Edit user")
          end
        end

        describe "success" do
      
          before(:each) do
            @attr = { :name => "New Name", :email => "user@example.org",
                  :password => "barbaz", :password_confirmation => "barbaz" }
          end
      
          it "should change the user's attributes" do
            put :update, :id => @user, :user => @attr
            @user.reload
            @user.name.should == @attr[:name]
            @user.email.should == @attr[:email]
            @user.encrypted_password.should == assigns(:user).encrypted_password
          end
      
          it "should have a flash message" do
            put :update, :id => @user, :user => @attr
            flash[:success].should =~ /updated/
          end
        end

        describe "authentication of edit/update pages" do
          before(:each) do
            @user = Factory(:user)
          end
          describe "for non-signed-in users" do
            it "should deny access to 'edit'" do
              get :edit, :id => @user
              response.should redirect_to(signin_path)
            end
            it "should deny access to 'update'" do
              put :update, :id => @user, :user => {}
              response.should redirect_to(signin_path)
            end
          end
        end
        describe "authentication of edit/update pages" do
          before(:each) do
            @user = Factory(:user)
          end
        describe "for non-signed-in users" do
          it "should deny access to 'edit'" do
            get :edit, :id => @user
            response.should redirect_to(signin_path)
          end
          it "should deny access to 'update'" do
            put :update, :id => @user, :user => {}
            response.should redirect_to(signin_path)
          end
        end

        describe "for signed-in users" do
          before(:each) do
            wrong_user = Factory(:user, :email => "user@example.net")
            test_sign_in(wrong_user)
          end

          it "should require matching users for 'edit'" do
            get :edit, :id => @user
            response.should redirect_to(root_path)
          end
          
          it "should require matching users for 'update'" do
            put :update, :id => @user, :user => {} 
            response.should redirect_to(root_path)
          end
        end
    end
  end

  



