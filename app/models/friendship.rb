class Friendship < ApplicationRecord

  # RELACIONES
  belongs_to :user
  belongs_to :friend, :class_name => 'User', primary_key: 'id', foreign_key: 'friend_id'

  # VALIDACIONES
  validates :user, uniqueness: { scope: :friend_id, message: 'La amistad ya fue solicitada.'}

  # SCOPE
  scope :confirmeds, -> {where("is_confirmed")}
  scope :pendents, lambda{|user_id| where('friend_id == ? AND (NOT is_confirmed)', user_id)}

  # DISPARADORES
  after_destroy do |f|
    reciprocal = Friendship.find_by(friend_id: f.user_id)
    reciprocal.destroy unless reciprocal.nil?
  end

end
