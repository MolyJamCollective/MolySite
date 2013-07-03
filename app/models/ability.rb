class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    user_groups = {
      webmasters: user.group?(:Webmasters),
      organizers: user.group?(:Organizers),
      hosts:      user.group?(:Hosts),
      jammers:    user.group?(:Jammers),
      users:      user.group?(:Users)
    }
 
    if user_groups[:organizers] || user_groups[:webmasters] 
      can :manage, :all 
      can [:approve, :show], Venue
    end

    if(user_groups[:hosts] || user_groups[:organizers] || user_groups[:webmasters])
      can [:manage, :move_up, :move_down], Sponsor
      can :manage, Attachment
      can :create, Venue
      can :host_resources, :page
    end

    if(user_groups[:users] || user_groups[:jammers] || user_groups[:hosts] || user_groups[:organizers] || user_groups[:webmasters])
      can :dashboard, :page
      can :manage, User, id: user.id
      can :create, Game
    end

    user.groups.each do |group|
     
      if group.memberships.where(user_id: user.id).first.role >= Membership::ROLES[:officer]
        can [:read, :update], Venue, group_id: group.id 
        can [:read, :update], Game, group_id: group.id
        can :read, Group, id: group.id

        if group.memberships.where(user_id: user.id).first.role >= Membership::ROLES[:founder]
          can :destroy, Venue, group_id: group.id
          can :destroy, Game, group_id: group.id 
          can :manage, Membership, group_id: group.id
          can [:add_user, :remove_user], Game, group_id: group.id
          cannot :destroy, Membership, role: Membership::ROLES[:founder]
        end
      end
      
    end

    can :show_current, Event
    can [:news, :about], :page
    can :show, Venue, approved: true
    can :index, Venue
    can :read, Game
    can [:index, :show], Inspiration

  end
end