require 'spec_helper'

describe "Static pages" do
   let(:base_title) { "Ruby on Rails Tutorial Sample App" }
   subject { page }
   shared_examples_for "Static pages" do 
     it { should have_selector('h1', text: heading) }
     it { should have_title(full_title(page_title)) }
   end
  describe "Home page" do
    before { visit root_path }
    let(:heading)     { 'Sample App' }
    let(:page_title)  {''}
    it_should_behave_like "Static pages"
    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user)}
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        sign_in user
        visit root_path
      end
      it "should render users feed" do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.content)
        end
      end
      describe "followed/following count" do
        let(:other_user) { FactoryGirl.create(:user) } 
        before do
          other_user.follow!(user)
          visit root_path
        end
      end
      it { should have_link("0 following", href: following_path_user(user)) }
      it { should have_link("1 following", href: followers_path_user(user)) }
    end
  end
  
  describe "Help page" do
    before {visit help_path }
    let(:heading)     { 'Help' }
    let(:page_title)  { 'Help' }
    it_should_behave_like "Static pages"
  end
  
  describe "About page" do
    before { visit about_path }
    let(:heading)     { 'About Us' }
    let(:page_title)  { 'About Us' }   
    it_should_behave_like "Static pages"
  end
  
  describe "Contact Page" do
    before { visit contact_path }
    let(:heading)     { 'Contact Us' }
    let(:page_title)  { 'Contact Us' }
    it_should_behave_like "Static pages"
  end 
   it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    expect(page).to have_title(full_title('About Us'))
    click_link "Help"
    expect(page).to have_title('Help')
    click_link "Contact"
    expect(page).to have_title('Contact Us')
    click_link "Home"
    click_link "Sign up now!"
    expect(page).to have_title('Sign Up')
    click_link "sample app"
    expect(page).to have_title('Ruby on Rails Tutorial Sample App')
  end
end
