class Credit < ActiveRecord::Base
  belongs_to :game
  belongs_to :user
  
  attr_accessible :game_id, :title, :user_id

  def find_or_invite_user(email, name)
    return if email.to_s.empty?

  	user = User.where(email: email).first

  	return self.user_id = user.id unless user.nil? || !user.confirmed?

    user = User.invite!(email: email, name: name)
    return self.user_id = user.id unless user.nil?

  end
end
