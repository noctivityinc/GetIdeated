class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :name, :password, :password_confirmation, :remember_me

  has_many :members, :dependent => :destroy 
  has_many :ideas, :through => :members
  has_many :own_ideas, :class_name => "Idea", :foreign_key => "user_id", :dependent => :destroy 
end
