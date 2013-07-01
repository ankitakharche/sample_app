require 'spec_helper'

describe "LayoutLinks" do

	it "should have a Home page at '/home'" do
		get '/home'
		response.should have_selector('title', :content => "Home")
    end

    it "should have a contact page at '/contact'" do
    	get '/contact'
    	response.should have_selector('title', :content => "Contact")
    end

    it "should have a contact page at '/about'" do
        get '/about'
        response.should have_selector('title', :content => "About")
    end

    it "should have a contact page at '/help'" do
        get '/help'
        response.should have_selector('title', :content => "Help")
    end

    it "should have a Signup page at '/signup'" do
        get '/signup'
        response.should have_selector('title', :content => "Sign up")
    end

    it "should have a Signin page at '/signin'" do
        get '/signin'
        response.should have_selector('title', :content => "Sign in")
    end

    it "should have right link on the layout" do 
        visit root_path
        response.should have_selector('title', :content => "Home")
        click_link "About"
        response.should have_selector('title', :content => "About")
        click_link "contact"
        response.should have_selector('title', :content => "contact")
        click_link "Home"
        response.should have_selector('title', :content => "Home")
        click_link "Signup"
        response.should have_selector('title', :content => "Signup")
        response.should have_selector('a[href ="/"]>img')
    end

end
