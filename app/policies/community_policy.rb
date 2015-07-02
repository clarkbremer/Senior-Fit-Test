class CommunityPolicy
  attr_reader :current_user, :model

  def initialize(current_user, community)
    @current_user = current_user
    @community = community
  end

  def index?
    @current_user.is_assessor?
  end

  def show?
    @current_user.is_admin? or @current_user.assessor_for_community?(@community)
  end

  def edit?
    @current_user.is_admin? or @current_user.assessor_for_community?(@community)
  end

  def update?
    @current_user.is_admin? or @current_user.assessor_for_community?(@community)
  end

  def create?
    @current_user.is_admin?
  end

  def destroy?
    @current_user.is_admin?
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.is_admin?
        scope.all
      elsif user.is_assessor?
        assessor = user.resident
        assessor.communities
      end
    end
  end

end
