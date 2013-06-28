require 'spec_helper'

describe "LayoutLinks" do

	it "should have a Home page at '/'" do
		get '/'
		response.should have_selector('title', :content => "Home")
    end

    it "should have a contact page at '/'" do
    	get '/contact'
    	response.should have_selector('title', :content => "Contact")
    end

    it "should have a Signup page at '/'" do
        get '/signup'
        response.should have_selector('title', :content => "Sign up")
    end

    it "should have a Signin page at '/'" do
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
