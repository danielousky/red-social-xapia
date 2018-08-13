class Comment < ApplicationRecord
  belongs_to :user
  accepts_nested_attributes_for :user

  scope :others, lambda{|user_id| where("user_id != ?", user_id)}
  scope :publics, -> {where("private IS FALSE")}
  scope :friendships, lambda{ |user_id| joins(:users).where("private IS TRUE & users.friends INCLUDE ?", user_id)}

  def public? 
  	self.private.eql? false
  end
end
