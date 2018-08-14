class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  # RELACIONES
  has_many :comments
  accepts_nested_attributes_for :comments
  has_many :friendships, dependent: :destroy
  has_many :friends, -> { Friendship.confirmeds }, through: :friendships, foreign_key: 'friend_id' 

  # SCOPE
  scope :search, lambda{|keywords| where('name ILIKE ? OR email ILIKE ?', "%#{keywords}%", "%#{keywords}%")}


end
