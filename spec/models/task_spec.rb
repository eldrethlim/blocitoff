require 'rails_helper'

describe Task do
  describe "#days_left" do
    it "should return 7 for new tasks" do
      task = Task.create!(name: 'Sample task')
      expect(task.days_left).to eq(7)
    end

    it "should return 6 for a task created yesterday" do
      task = Task.create!(name: 'Old task', created_at: 1.day.ago)
      expect(task.days_left).to eq(6)
    end

    it "should return 0 for a week old task" do
      task = Task.create!(name: 'Old task', created_at: 1.week.ago)
      expect(task.days_left).to eq(0)
    end
  end
end