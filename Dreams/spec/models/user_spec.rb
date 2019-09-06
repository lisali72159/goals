require 'rails_helper'

RSpec.describe User, type: :model do
  
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_presence_of(:session_token) }
  it { should validate_length_of(:password).is_at_least(6) }

  describe 'uniqueness' do
    before :each do 
      create(:user) 
    end
    
    context 'it should validate uniqueness of username' do
      it { should validate_uniqueness_of(:username) }
    end

    context 'it should validate uniqueness of session token' do
      it { should validate_uniqueness_of(:session_token) }
    end
  end

  describe 'find_by_credentials' do
    let!(:user) {create(:user)}
    

    context 'with valid credentials' do
      it 'should return user' do
        expect(user.find_by_credentials(user.username, 'straws')).to eq(user)
      end
    end

    context 'with invalid credentials' do
      it 'should return nil' do
        expect(user.find_by_credentials(user.username, 'flaws')).to eq(nil)
      end
    end
  end

  describe 'is_password?' do
    let!(:user) { create(:user) }

    context 'a valid password' do
      it 'should return true' do
        expect(user.is_password?('straws')).to eq(true)
      end
    end

    context 'with invalid credentials' do
      it 'should return false' do
        expect(user.is_password?('flaws')).to eq(false)
      end
    end
  end

  describe 'generate_session_token' do
    let!(:user) { create(:user) }

    it 'generates a session token' do
      expect(User.generate_session_token).not_to be(nil)
    end
  end

  describe 'password=' do
    let!(:user) { create(:user) }
    
    it 'creates a password digest' do
      expect(@password).not_to eq(user.password_digest)
      expect(user.password_digest).not_to eq(nil)
    end
  end

  describe 'ensure_session_token' do
    let!(:user) { create(:user) }

    context 'when there is a session token' do
      it 'should return existing session token' do
        expect(user.session_token).to eq(user.ensure_session_token)
      end
    end

    context 'when there is no session token' do
      before :each do
        create(:fake_user)
      end

      it 'should create a session token' do
        expect(fake_user.ensure_session_token).not_to eq(nil)
      end
    end
  end

  describe 'reset_session_token!' do
    let!(:user) { create(:user) }

      it 'should reset the session token!' do
        old_session_token = user.session_token
        expect(user.reset_session_token!).not_to eq(old_session_token)
      end

  end
end

