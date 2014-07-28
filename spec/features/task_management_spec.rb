require 'rails_helper'

describe 'Task management' do
  before do
    @user = User.new(username: 'michal', email: 'michal@trivas.pl',
      password: 'Password1', password_confirmation: 'Password1')
    @user.skip_confirmation!
    @user.save!
  end

  it 'should allow a user to add a new task' do
    sign_in @user, 'Password1'
    fill_in 'Task name', with: 'Refactor User model'
    click_button 'Add'
    expect(page).to have_content('Task added')
    expect(page).to have_content('Refactor User model')
    expect(current_path).to eq('/')
  end

  it 'should not allow a user to add a task without a name' do
    sign_in @user, 'Password1'
    click_button 'Add'
    expect(page).to have_content('Task not added')
    expect(current_path).to eq('/')
  end

  private

  def sign_in(user, password)
    visit '/'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'Password1'
    click_button 'Sign in'
    expect(page).to have_content('Signed in successfully.')
    expect(current_path).to eq('/')
  end
end