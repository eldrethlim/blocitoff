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
    fill_in 'Task name', with: 'This is a test task.'
    click_button 'Add Task'
    expect(page).to have_content('New task added.')
    expect(page).to have_content('This is a test task.')
    expect(current_path).to eq('/')
  end

  it 'should not allow a user to add a task without a name' do
    sign_in @user, 'Password1'
    click_button 'Add Task'
    expect(page).to have_content('Error adding task.')
    expect(current_path).to eq('/')
  end

  it 'should allow a user to edit a task' do
    sign_in @user, 'Password1'
    fill_in 'Task name', with: 'This is another test task.'
    click_button 'Add Task'
    click_link 'This is another test task.'
    fill_in 'Task name', with: 'This is the edited task.'
    click_button 'Edit Task'
    expect(page).to have_content('Task updated.')
    expect(page).to have_content('This is the edited task.')
    expect(current_path).to eq('/')
  end

  it 'should not allow a user to edit a task into an empty name field' do
    sign_in @user, 'Password1'
    fill_in 'Task name', with: 'This is just another test task.'
    click_button 'Add Task'
    click_link 'This is just another test task.'
    fill_in 'Task name', with: ""
    click_button 'Edit Task'
    expect(page).to have_content('Error updating task.')
    expect(current_path).to eq('/')
  end

  it 'should allow a user to delete a task' do
    sign_in @user, 'Password1'
    fill_in 'Task name', with: 'A task'
    click_button 'Add Task'
    click_link 'Delete'
    expect(page).to have_no_content('A task')
    expect(page).to have_content('Task deleted.')
    expect(current_path).to eq('/')
  end

  it 'should allow a user to complete a task' do
    sign_in @user, 'Password1'
    fill_in 'Task name', with: 'A task'
    click_button 'Add Task'
    click_link 'Completed?'
    expect(page).to have_content('Task completed. Good job!')
    expect(current_path).to eq('/')
  end

  it 'should allow a user to incomplete a task' do
    sign_in @user, 'Password1'
    fill_in 'Task name', with: 'a task'
    click_button 'Add Task'
    click_link 'Complete'
    click_link 'Incomplete?'
    expect(page).to have_content("It's not done after all!")
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