class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    webmasters = user.group?(:Webmasters)
    organizers = user.group?(:Organizers) 
    hosts      = user.group?(:Hosts)
    jammers    = user.group?(:Jammers)
    users      = user.group?(:Users)

    # Want Cascading 'C' Style Switch Statment
    if(webmasters)
    end

    if(organizers || webmasters)
      can :manage, :all
      can :approve, Venue
      can :show, Venue
    end

    if(hosts || organizers || webmasters)
      user.groups.each do |group|
        can [:read, :update, :destroy], Venue, group_id: group.id
        can :read, group
        can :manage, Membership, group_id: group.id
        cannot :destroy, Membership, role: Membership::ROLES[:founder]
      end

      can [:manage, :move_up, :move_down], Sponsor
      can :manage, Attachment
      can :create, Venue
      can :host_resources, :page
    end

    if(jammers || hosts || organizers || webmasters)
      can :manage, UserFileUpload, user_id: user.id
    end

    if(users || jammers || hosts || organizers || webmasters)
      can :dashboard, :page
      can :manage, User, id: user.id
      can :create, Game
    end

    can :show_current, Event
    can [:news, :about], :page
    can :show, Venue, approved: true
    can :index, Venue
    can :read, Game
    can [:index, :show], Inspiration

  end
end
