class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  has_many :comments
  accepts_nested_attributes_for :comments

  scope :search, lambda{|keywords| where('name LIKE ? OR email LIKE ?', "%#{keywords}%", "%#{keywords}%")}
  # scope :search, -> {where('name LIKE ?', '%Dan%')}
  # scope :search, -> {where('id != ?', 3)}

  has_many :friendships, dependent: :destroy
  has_many :friends, -> { Friendship.confirmeds }, through: :friendships, foreign_key: 'friend_id' 

end
