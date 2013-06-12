class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    # Want Cascading 'C' Style Switch Statment
    if(user.group?(:Webmasters))
    end

    if(user.group?(:Organizers) || user.group?(:Webmasters))
      can :manage, :all
      can :approve, Venue
      can :show, Venue
    end

    if(user.group?(:Hosts) || user.group?(:Organizers) || user.group?(:Webmasters))
      user.groups.each do |group|
        can :manage, Venue, group_id: group.id
      end

      can :manage, Sponsor
      can :move_up, Sponsor
      can :move_down, Sponsor

      can :create, Venue
    end

    if(user.group?(:Jammers) || user.group?(:Hosts) || user.group?(:Organizers) || user.group?(:Webmasters))
      can :create, UserFileUpload
      can :show, UserFileUpload
    end

    if(user.group?(:Users) || user.group?(:Jammers) || user.group?(:Hosts) || user.group?(:Organizers) || user.group?(:Webmasters))
      can :dashboard, :page
      can :manage, User, id: user.id
    end

    can :show_current, Event
    can :about, :page
    can :show, Venue, approved: true
    can :index, Venue

  end
end
