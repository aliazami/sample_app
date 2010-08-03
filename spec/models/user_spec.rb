require 'spec_helper'

describe User do
  before(:each) do
    @attr = {
      :name => "sample_user_name",
      :email => "sample_user@mailserver.com"
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end
  
  it "should require a name" do
    no_name_user=User.new(@attr.merge(:name => ""))
    no_name_user.should_not be_valid
  end
  
  it "should require a email" do
    no_email_user=User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end
  
  it "should reject names that are too long" do
    long_name="a" * 21
    long_name_user=User.new(@attr.merge(:name => long_name))
    long_name_user.should_not be_valid
  end
  
  it "should accept vaild emails" do
    vaild_addresses=%w[user@foo.com THE_USER@foo.bar.org first.last@gmail.co.uk]
    vaild_addresses.each do |address|
      valid_user=User.new(@attr.merge(:email =>address))
      valid_user.should be_valid
    end
  end
  
  it "should reject invaild email addresses" do
    invalid_email_address=%w[user@foo,com user_at_foo.org example.user@foo.]
    invalid_email_address.each do |address|
      invalid_user=User.new(@attr.merge(:email => address))
      invalid_user.should_not be_valid
    end
  end
  
  it "should reject douplicate emails identical up to case" do
    
    first_valid_user=User.create!(@attr.merge(:email => @attr[:email].upcase))
    second_invalid_user=User.new(@attr)
    second_invalid_user.should_not be_valid
  end
    
  
end
