class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    # Want Cascading 'C' Style Switch Statment
    if(user.group?(:Webmasters))
      can :manage, :all
    end

    if(user.group?(:Organizers) || user.group?(:Webmasters))
      can :manage, :all
    end

    if(user.group?(:Hosts) || user.group?(:Organizers) || user.group?(:Webmasters))
      user.groups.each do |group|
        can :manage, Venue, group_id: group.id
      end
    end

    if(user.group?(:Jammers) || user.group?(:Hosts) || user.group?(:Organizers) || user.group?(:Webmasters))

    end

    if(user.group?(:Users) || user.group?(:Jammers) || user.group?(:Hosts) || user.group?(:Organizers) || user.group?(:Webmasters))
      can :create, Venue
    end

    can :read, :all
    can :show_current, Event

  end
end

