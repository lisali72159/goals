require 'rails_helper'

describe 'GET #index' 
  it 'renders the dreams and hopes index' do
    get(:index)
    expect(response).to render_template(:index)
  end
end

describe 'GET #show' do
  before :each do 
    create(:user)
    allow(subject).to_receive(:current_user).and_return(User.last)
  end

  allow(subject).to_receive(:logged_in?).and_return(true)

  it 'renders the show index' do
    get(:show)
    expect(response).to render_template(:show)
  end
end

describe 'POST #create' do
  # before :each do 
  #   create(:user)
  #   allow(subject).to_receive(:current_user).and_return(User.last)
  # end

  # allow(subject).to_receive(:log_in).and_return(true)
  context 'with valid username and password' do
    it 'create a new user' do
    post(:create)
    expect(response).to render_template(:create)
    end

  context 'with invalid usernamer and/or password' do
      it 'redirects to new user form and displays errors' do
        expect(flash[:errors])
      end
    end

  end
