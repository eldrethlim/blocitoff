class Task < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :name

  after_create :set_complete_false

  def set_complete_false
    self.update(complete: false)
  end

  def days_left
    7 - days_elapsed
  end

  def days_elapsed
    ((Time.now - self.created_at)/1.day).to_i
  end
end