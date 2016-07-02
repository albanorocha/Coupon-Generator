class UserPolicy< ApplicationPolicy

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def permitted_attributes
    if user.admin?
      [:name, :email, :password, :role]
    else
      [:name, :email, :password]
    end
  end

  def index?
    true
  end

  def new?
    user.admin?
  end

  def create?
    user.admin?
  end

  def show?
    user.admin? or user == record
  end

  def edit?
    user.admin? or record == user
  end

  def update?
    user.admin? or user == record
  end

  def edit_password?
    user.admin? or record == user
  end

  def update_password?
    user.admin? or record == user
  end

  def destroy?
    user == record or user.admin?
  end

end
