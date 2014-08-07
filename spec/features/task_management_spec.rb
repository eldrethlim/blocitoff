require 'rails_helper'

describe 'Task management' do
  before do
    Capybara.current_driver = :poltergeist
    @user = User.new(username: 'michal', email: 'michal@trivas.pl',
      password: 'Password1', password_confirmation: 'Password1')
    @user.skip_confirmation!
    @user.save!
    sign_in @user
  end

  it 'should allow a user to add a new task' do
    fill_in_task
    expect(page).to have_content('New task added.')
    expect(page).to have_content('A task')
    expect(current_path).to eq('/')
  end

  it 'should not allow a user to add a task without a name' do
    click_link 'Add a new task'
    click_button 'Save'
    expect(page).to have_content("You can't create an empty task!")
    expect(current_path).to eq('/')
  end

  it 'should allow a user to edit a task' do
    fill_in_task
    click_link 'A task'
    fill_in 'Task name', with: 'This is the edited task.'
    click_button 'Save'
    expect(page).to have_content('Task updated.')
    expect(page).to have_content('This is the edited task.')
    expect(current_path).to eq('/')
  end

  it 'should not allow a user to edit a task into an empty name field' do
    fill_in_task
    click_link 'A task'
    fill_in 'Task name', with: ""
    click_button 'Save'
    expect(page).to have_content('Error updating task.')
    expect(current_path).to eq('/')
  end

  it 'should allow a user to delete a task' do
    fill_in_task
    click_link 'Delete'
    expect(page).to have_no_content('A task')
    expect(page).to have_content('Task deleted.')
    expect(current_path).to eq('/')
  end

  it 'should allow a user to complete a task' do
    fill_in_task
    click_button 'Completed?'
    expect(page).to have_content('Task completed. Good job!')
    expect(current_path).to eq('/')
  end

  it 'should allow a user to incomplete a task' do
    fill_in_task
    click_button 'Completed?'
    click_button 'Incomplete?'
    expect(page).to have_content("It's not done after all!")
    expect(current_path).to eq('/')
  end

  private
  
  def fill_in_task
    click_link 'Add a new task'
    fill_in 'Task name', with: 'A task'
    click_button 'Save'
  end

  def sign_in(user)
    visit '/'
    fill_in 'Username', with: user.username
    fill_in 'Password', with: 'Password1'
    click_button 'Sign in'
    expect(page).to have_content('Signed in successfully.')
    expect(current_path).to eq('/')
  end
end