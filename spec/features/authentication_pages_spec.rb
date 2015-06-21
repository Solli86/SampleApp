require 'spec_helper'

describe "Authentication" do
  
  subject { page }
  describe "sign in page" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Sign in" }
      
      it { should have_title("Sign in") }
      #it { should have_selector('.alert-danger') }
      it { should have_error_message('Invalid') }
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
      it { should have_link('Settings',    href: edit_user_path(user)) }
      it { should have_link('Sign out',     href: signout_path) }
      it { should_not have_link('Sign in',  href: signin_path) }
    end
    describe "visit another page" do
      before { click_link "Home"}
      #it { should_not have_selector(".alert-danger")}
      it { should_not have_error_message('Invalid') }
    end
  end
  describe "autorization" , type: :request do
    describe "non signed up user" do
      let(:user) { FactoryGirl.create(:user) }

      describe "AuthenticationPages" do

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_title('Sign in') }
        end
        
        describe "submitting to the update action" do
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(signin_path) }
        end
      end
    end
    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { sign_in user, no_capybara: true }

      describe "submitting a GET request to the Users#edit action" do
        before { get edit_user_path(wrong_user) }
        specify { expect(response.body).not_to match(full_title('Edit user')) }
        specify { expect(response).to redirect_to(root_path) }
      end

      describe "submitting a PATCH request to the Users#update action" do
        before { patch user_path(wrong_user) }
        specify { expect(response).to redirect_to(root_path) }
      end
    end
  end
end
