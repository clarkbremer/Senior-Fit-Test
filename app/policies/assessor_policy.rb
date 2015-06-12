class AssessorPolicy
  attr_reader :current_user, :model

  def initialize(current_user, assessor)
    @current_user = current_user
    @assessor = assessor
  end

  def index?
    @current_user.admin?
  end

  def show?
    @current_user.admin? or
    @current_user == @assessor.user
  end

  def update?
    @current_user.admin?
  end

  def edit?
    @current_user.admin?
  end

  def create?
    @current_user.admin?
  end

  def destroy?
    @current_user.admin?
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.admin?
        scope.all
      end
    end
  end



end
