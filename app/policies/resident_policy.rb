class ResidentPolicy
  attr_reader :current_user, :model

  def initialize(current_user, resident)
    @current_user = current_user
    @resident = resident
  end

  def index?
    @current_user.is_admin?
  end

  def show?
    @current_user.is_admin? or
    @current_user == @resident.user or
    @current_user.assessor_for_resident?(@resident)
  end

  def update?
    @current_user.is_admin? or @current_user.assessor_for_resident?(@resident)
  end

  def edit?
    update?
  end

  def create?
    update?
  end

  def destroy?
    update? && @resident.user && @resident.user != @current_user && @resident.is_admin? == false
  end

  def make_assessor?
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
        assessor = user.asessor
        scope.where(community: assessor.communities)
      end
    end
  end



end
