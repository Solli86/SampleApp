require 'spec_helper'
describe User do
  before  { @user = User.new( name: "Solli_86", email: "solli@mix.up", password: "foobar", password_confirmation: "foobar") }
  subject { @user }
  it {       should   respond_to(:name)                  }
  it {       should   respond_to(:email)                 }
  it {       should   respond_to(:password_digest)       }
  it {       should   respond_to(:password)              }
  it {       should   respond_to(:remember_token)        }
  it {       should   respond_to(:password_confirmation) }
  it {       should   respond_to(:authenticate)          }
  it {should be_valid }
  # name column spec
  describe "When name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end
  describe "When name is not present" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end
  #email column spec
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
  describe "email adress is mixed case" do
    let(:mixed_case_email) { "FooBAe@ya.er" }
    it 'should saved as lower case' do
      @user.email = mixed_case_email
      @user.save
      expect(@user.reload.email).to eq  mixed_case_email.downcase
    end
  end

  #Password validation
  describe "when password is not present" do
    before do
      @user = User.new(name: "Example User", email: "user@example.com", password: " ", password_confirmation: " ")
    end
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end
    describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be false }
    end
    describe "with a password that's too short" do
      before { @user.password = @user.password_confirmation = "a" * 5 }
      it { should be_invalid }
    end
    # token validate
    describe "remember token" do
      before { @user.save }
      it { expect(@user.remember_token).not_to be_blank }
    end
  end


   # Admin validation
   it { should respond_to(:authenticate) }
   it { should respond_to (:admin) } 

   it { should be_valid }
   it { should_not be_admin }
   
   describe "with admin attribute set to 'true'" do
     before do
       @user.save!
       @user.toggle!(:admin)
     end

     it { should be_admin }
   end

 #microposts flow
  it { should respond_to(:microposts)   }
  it { should respond_to(:feed)         }
  it { should respond_to(:relationship) }
  it { should respond_to(:following?)   }
  it { should respond_to(:follow!)      }
  it { should respond_to(:unfollow!)    }

  describe "following" do
    let(:other_user) { FactoryGirl.create(:user) }
    before do
      @user.save
      @user.follow!(other_user)

      it { should be_following(:other_user) }
      its(:followed_users) { should include(other_user) }

      describe "and unfollowing" do
        before { @user.unfollow!(other_user) }

        it { should_not be_following(other_user) }
        its(:followed_user) { should_not include(other_user) }
      end
    end
  end

  describe "micropost associations" do
    before { @user.save }
    let!(:older_micropost) do
      FactoryGirl.create(:micropost, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_micropost) do
      FactoryGirl.create(:micropost, user: @user, created_at: 1.hour.ago)
    end
    it 'should have the right microposts in the right order' do
      expect(@user.microposts.to_a).to eq [newer_micropost, older_micropost]
    end

    it "should destroy associated microposts" do
      microposts = @user.microposts.to_a
      @user.destroy
      expect(microposts).not_to be_empty
      microposts.each do |micropost|
        expect(Micropost.where(id: micropost.id)).to be_empty
      end
    end
    describe "status" do
      let(:unfollowed_post) do
        FactoryGirl.create(:micropost, user: FactoryGirl.create(:user))
      end

      its(:feed) { should include(newer_micropost) }
      its(:feed) { should include(older_micropost) }
      its(:feed) { should_not include(unfollowed_post) }
    end
  end

end
