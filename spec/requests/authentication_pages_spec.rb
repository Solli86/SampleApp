require 'spec_helper'

describe "Authentication" do
  
  subject { page }
  describe "sign in page" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Sign in" }
      
      it { should have_title("Sign in") }
      it { should have_selector('.alert-danger') }
    end
    describe "with valid sign in" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "email",    with:  user.email.upcase
        fill_in "password", with: user.password
        click_button "Sign in"
      end

      it { should have_title(user.name) }
      it { should have_link('Profile',      href: user_path(user)) }
      it { should have_link('Sign out',     href: signout_path) }
      it { should_not have_link('Sign in',  href: signin_path) }
    end
    describe "visit another page" do
      before { click_link "Home"}
      it { should_not have_selector(".alert-danger")}
    end
  end
end
