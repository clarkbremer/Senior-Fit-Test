class CommunityPolicy
  attr_reader :current_user, :model

  def initialize(current_user, community)
    @current_user = current_user
    @community = community
  end

  def index?
    @current_user.assessor?
  end

  def show?
    @current_user.admin? or @current_user.assessor_for_community?(@community)
  end

  def edit?
    @current_user.admin? or @current_user.assessor_for_community?(@community)
  end

  def update?
    @current_user.admin? or @current_user.assessor_for_community?(@community)
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
      elsif user.assessor?
        assessor = user.person
        puts "Assessor #{assessor.name} belongs to these communities: #{assessor.communities.to_s}"
        assessor.communities
      end
    end
  end

end
