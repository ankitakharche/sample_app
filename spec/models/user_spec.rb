# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe User do
   before(:each) do
   	@attr = {:name => "example user", :email => "example email"}
   end

  it "should create a new instance given a valid instance" do
  	user.create!(:name => "Example user" , :email => "Example email")
  end

  it "should require a name" do 
  	no_user_name = User.new(@attr.merge(:name => ""))
  	no_user_name.should_not be_valid
  end

  it "should require an email" do
  	no_user_email = User.new(@attr.merge(:email => ""))
  	no_user_email.should_not be_valid
  end

  it "should reject name to long" do 
    long_name = "a" * 51
    long_name_user = User.new(@attr.merge(:name => "long_name"))
    long_name_user.should_not be_valid
  end

  it "should accept valid email address" do 
    address = %w[user@foo.com , The_USER@foo.bar.org , first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email =>"Example email"))
      valid_email_user.should be_valid
    end
  end

  it "should reject invalid email addresses" do
   addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
   addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
   end
  end

  it "should reject duplicate email" do 
    user.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

  it "should reject email address identical up to case" do
    upcased_email = @attr[:email].upcase
    user_create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
end
