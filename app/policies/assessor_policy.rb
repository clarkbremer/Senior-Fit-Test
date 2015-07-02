class AssessorPolicy
  attr_reader :current_user, :model

  def initialize(current_user, assessor)
    @current_user = current_user
    @assessor = assessor
  end

  def index?
    @current_user.is_admin?
  end

  def show?
    @current_user.is_admin? or
    @current_user == @assessor.resident.user
  end

  def update?
    @current_user.is_admin?
  end

  def edit?
    @current_user.is_admin?
  end

  def create?
    @current_user.is_admin?
  end

  def destroy?
    @current_user.is_admin? && assessor.resident.is_admin? == false
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
      end
    end
  end



end
