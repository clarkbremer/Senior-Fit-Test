class AssessmentPolicy
  attr_reader :current_user, :model

  def initialize(current_user, assessment)
    @current_user = current_user
    @assessment = assessment
  end

  def index?
    @current_user.is_assessor?
  end

  def show?
    @current_user.is_admin? or
    @current_user == @assessment.resident.user or
    @current_user.assessor_for_resident?(@assessment.resident)
  end

  def update?
    @current_user.is_assessor?
  end

  def edit?
    update?
  end

  def create?
    update?
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
        scope.where(community: assessor.communities)
      end
    end
  end



end
