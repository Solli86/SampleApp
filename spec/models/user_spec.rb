require 'spec_helper'
describe User do
  before  { @user = User.new( name: "Solli_86", email: "solli@mix.up") }
  subject { @user }
  it { should respond_to(:name)  }
  it { should respond_to(:email) }
  it  {should be_valid }

  describe "When name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end
  describe "When name is not present" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end
  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end
  describe "when email adress alredi taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end
    it { should_not be_valid }
  end
end
