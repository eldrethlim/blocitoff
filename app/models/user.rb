class User < ActiveRecord::Base
  include FriendlyId
  friendly_id :username, use: :slugged
  has_many :tasks
  validates_uniqueness_of :username, :email
  validates :username, presence: true

  # Include default devise modules. OThers available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
end