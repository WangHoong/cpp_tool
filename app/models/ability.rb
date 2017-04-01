class Ability
  include CanCan::Ability

  def initialize(user)
    # authorize
    user ||= User.new

    can :manage,:all
  end  #initialize
end
