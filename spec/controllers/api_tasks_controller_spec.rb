require 'rails_helper'

describe Api::TasksController do
  it 'should list tasks of a given user' do
    user = create_user
    task = Task.create!(user: user, name: 'First task')

    get :index, user_id: user.id
    json = JSON.parse(response.body)
    task_json = json["tasks"].first
    expect(task_json.keys).to eq(["id", "name", "user_id", "created_at", "updated_at", "complete", "days_left"])
    expect(task_json["name"]).to eq("First task")
    expect(task_json["user_id"]).to eq(user.id)
    expect(task_json["days_left"]).to eq(7)
  end

  it 'should allow user to create tasks' do
    user = create_user

    expect {
      post :create, user_id: user.id, task: {name: 'First task'}
    }.to change(user.tasks, :count).by(1)

    json = JSON.parse(response.body) # json = {"task" => ...}
    task_json = json["task"]
    expect(task_json.keys).to eq(["id", "name", "user_id", "created_at", "updated_at", "complete", "days_left"])
    expect(task_json["name"]).to eq("First task")
    expect(task_json["user_id"]).to eq(user.id)
  end

  it 'should allow user to update tasks' do
    user = create_user

    task = Task.create!(user: user, name: 'First task')
    put :update, user_id: user.id, id: task.id, task: {name: 'Edited first task'}

    json = JSON.parse(response.body)
    task_json = json["task"]
    expect(task_json.keys).to eq(["id", "name", "user_id", "created_at", "updated_at", "complete", "days_left"])
    expect(task_json["name"]).to eq("Edited first task")
  end

  it 'should allow user to delete tasks' do
    user = create_user
    task = Task.create(user: user, name: 'first task')

    delete :destroy, user_id: user.id, id: task.id

    json = JSON.parse(response.body)
    expect(json).to eq({'result' => 'Deleted'})
  end

  def create_user
    user = User.new(username: 'michal', email: 'michal@trivas.pl',
      password: 'Password1', password_confirmation: 'Password1')
    user.skip_confirmation!
    user.save!
    user
  end
end