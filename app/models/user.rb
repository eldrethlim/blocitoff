class User < ActiveRecord::Base
  has_many :tasks
  validates_uniqueness_of :username
  validates_uniqueness_of :email

  # Include default devise modules. OThers available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
end