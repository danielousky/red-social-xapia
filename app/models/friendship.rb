class Friendship < ApplicationRecord

  # RELACIONES
  belongs_to :user
  belongs_to :friend, :class_name => 'User'


  # VALIDACIONES
  validates :user, uniqueness: { scope: :friend_id, message: 'La amistad ya fue solicitada.'}

  # SCOPE
  scope :confirmeds, -> {where("is_confirmed IS 1")}

  # DISPARADORES
  # Para mantener la bidireccionaldad de las amistades
  after_create do |f|
    if !Friendship.find_by(user_id: self.friend_id, friend_id: self.user_id)
      Friendship.create!(user_id: self.friend_id, friend_id: self.user_id)
    end
  end
  
  # after_update do |f|
  #   reciprocal = Friendship.find_by(friend_id: f.user_id)
  #   unless reciprocal.nil?
  #     # reciprocal.is_confirmed = self.is_confirmed
  #     # reciprocal.save!
  #     reciprocal.update(is_confirmed: self.is_confirmed) unless reciprocal.nil?
  #   end
  # end

  after_destroy do |f|
    reciprocal = Friendship.find_by(friend_id: f.user_id)
    reciprocal.destroy unless reciprocal.nil?
  end

end
