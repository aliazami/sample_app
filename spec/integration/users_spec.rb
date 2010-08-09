require 'spec_helper'

describe "Users" do
  
  describe "Signup" do
    
    describe "Failure" do

     it "should not make a new user" do
      lambda do
	visit signup_path
	click_button
	response.should render_template('users/new')
	response.should have_tag("div#errorExplanation")
      end.should_not change(User, :count)
     end
    
    
    end

    describe "success" do
      lambda do
	visit signup_path
	fill_in "Name",		:with => "Example User"
	fill_in "Email",	:with => "user@example.com"
	fill_in "Password",	:with => "somepassword"
	fill_in "Confirmation",	:with => "somepassword"
	click_button
	response.should render_template("users/show")
      end#.should change(User, :count).by(1)
    end
  end
end
