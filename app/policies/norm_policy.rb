class NormPolicy
  attr_reader :current_user, :model

  def initialize(current_user, norm)
    @current_user = current_user
    @norm = norm
  end

  def index?
    @current_user.is_admin?
  end

  def show?
    @current_user.is_admin?
  end

  def edit?
    @current_user.is_admin?
  end

  def update?
    @current_user.is_admin?
  end

  def destroy?
    @current_user.is_admin?
  end

end
