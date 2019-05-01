# # we test the user actually respond to this attribute
# it { should respond_to(:auth_token) }




# # we test the auth_token is unique
# it { should validate_uniqueness_of(:auth_token)}

#  	describe "#generate_authentication_token!" do
#     it "generates a unique token" do
#       Devise.stub(:friendly_token).and_return("auniquetoken123")
#       @user.generate_authentication_token!
#       expect(@user.auth_token).to eql "auniquetoken123"
#     end



require 'spec_helper'
