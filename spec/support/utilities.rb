include ApplicationHelper
def full_title(page_title)
  base_tite = "Ruby on Rails Tutorial Sample App"
  if page_title.empty?
    base_tite
  else
    "#{base_tite} | #{page_title}"
  end
end
# error messege helper
RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-danger', text: message)
  end
end
# valid fill fields
def valid_signin(user)
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
end
def sign_in(user, options={})
  if options[:no_capybara]
    # Sign in when not using Capybara.
    remember_token = User.new_remember_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
  else
    visit signin_path
    fill_in "email",    with: user.email
    fill_in "password", with: user.password
    click_button "Sign in"
  end
end
