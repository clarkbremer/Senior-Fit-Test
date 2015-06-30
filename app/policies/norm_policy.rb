class NormPolicy
  attr_reader :current_user, :model

  def initialize(current_user, norm)
    @current_user = current_user
    @norm = norm
  end

  def index?
    @current_user.admin?
  end

  def show?
    @current_user.admin?
  end

  def edit?
    @current_user.admin?
  end

  def update?
    @current_user.admin?
  end

  def destroy?
    @current_user.admin?
  end

end
