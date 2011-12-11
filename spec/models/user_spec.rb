require 'spec_helper'

describe User do

  before(:each) do
    @attr = { :name => "Example User", :email => "example@example.com" }
  end
  
  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end
  
  it "should require a name" do
    no_name_user = User.new(@attr.merge(:name => ""))
    no_name_user.should_not be_valid
  end
  
  it "should require an email" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end
  
  it "should reject names that are too long" do
    long_name = 'a' * 51
    long_name_user = User.new(@attr.merge(:name => long_name))
    long_name_user.should_not be_valid
  end
  
  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@goo.ber.org first.last@email.com]
    addresses.each do |addy|
      valid_email_user = User.new(@attr.merge(:email => addy))
      valid_email_user.should be_valid
    end
  end
  
  it "should reject invalid email addresses" do
    addresses = %w[userd@foo,com THE_USER_at_goo.ber.org first.last@email.]
    addresses.each do |addy|
      invalid_email_user = User.new(@attr.merge(:email => addy))
      invalid_email_user.should_not be_valid
    end
  end
  
  it "should reject duplicate email addresses" do
    User.create!(@attr)
    user_with_dupe_email = User.new(@attr)
    user_with_dupe_email.should_not be_valid
  end
  
  it "should reject duplicate email addresses even with case" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_with_dupe_email = User.new(@attr)
    user_with_dupe_email.should_not be_valid
  end
  
end

# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

