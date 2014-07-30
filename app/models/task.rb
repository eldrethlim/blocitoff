class Task < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :name

  after_create :set_complete_false

  def set_complete_false
    self.update(complete: false)
  end
end