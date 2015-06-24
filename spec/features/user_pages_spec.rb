require 'spec_helper'
describe "User page" do

  subject { page }

  describe "signup page" do
    before { visit signup_path }
    it { should have_content('Sign up')}
    it { should have_title(full_title('Sign Up'))}
  end
  describe "index" do
    let(:user) { FactoryGirl.create(:user) }

    before do
      sign_in user
      visit users_path
    end

    it { should have_title("All users") }
    it {should have_content("All users") }

     describe "delete links" do

       it { should_not have_link('delete') }

       describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
         before do
           sign_in admin
           visit users_path
         end

         it { should have_link('delete', href: user_path(User.first)) }
         it 'should be able delete another user' do
           expect do
             click_link('delete', match: :first)
           end.to change(User, :count).by(-1)
         end
         it { should_not have_link('delete', href: user_path(admin)) }
       end

     end

    it 'should list each user' do
      User.all.each do |user|
        expect(page).to have_selector('li', text: user.name)
      end
    end
  end
  describe "profile page" do
    let(:user) { FactoryGirl.create(:user)}
    before { visit user_path(user) }
    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end  
    describe "Sign up page" do
      before { visit signup_path}

      let(:submit) { "Create my account" }

      describe "with invalid information" do
        it 'should not create a user ' do
          expect { click_button submit }.not_to change(User, :count)
        end
      end
      describe "with valid information" do
        before  do
          fill_in "name",                     with: "Example User"
          fill_in "email",                    with: "user@example.com"
          fill_in "password",                 with: "foobar"
          fill_in "confirm the password",     with: "foobar"
        end
          it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
      describe "after saving the user" do
        before { click_button submit } 
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_link("Sign out") }
        it { should have_title(user.name) }
        it { should have_selector('.alert-success', text: 'Welcome') }
      end
    end
  end




#  describe "edit" do
#    let(:user) { FactoryGirl.create(:user) }
#    before { visit signin_path } 
#    
#    before do
#      fill_in "email", with: user.email
#      fill_in "password", with: user.password
#    end
#
#    describe "with invalid information" do
#      before { click_button "Save changes" }
#      it { should have_content('error') }
#    end
#    describe "with valid information" do
#      before { visit edit_user_path(user) }
#      let(:new_name)  { "New Name" }
#      let(:new_email) { "new@example.com" }
#      before do
#        fill_in "name",                 with: new_name
#        fill_in "email",                with: new_email
#        fill_in "password",             with: user.password
#        fill_in "confirm the password", with: user.password_confirmation
#        click_button "Save changes"
#      end
#      it { should have_title(new_name) }
#      it { should have_selector('div.alert.alert-success', text: "Profile updated") }
#      it { should have_link('Sign out', href: signout_path) }
#      specify { expect(user.reload.name).to  eq new_name }
#      specify { expect(user.reload.email).to eq new_email }
#    end
#  end




end
