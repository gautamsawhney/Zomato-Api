class PostPolicy < ApplicationPolicy

  # Autobot: Read Scope

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      raise Pundit::NotAuthorizedError, "" unless user 
      @user  = user
      @scope = scope
    end

    def resolve
      if user.restaurant_owner? || user.super_admin? || user.mod?
        scope.all
      else
        scope.none
      end
    end
  end

  # Autobot: Permitted Attributes



  # Autobot: Permitted Actions
def destroy?
                #return true if record.user_id == user.id
                user.super_admin? || user.mod?
              end
def update?
                #return true if record.user_id == user.id
                user.restaurant_owner? || user.super_admin? || user.mod?
              end
 def show?
                  user.restaurant_owner? || user.super_admin? || user.mod?
                end
def create?
                #return true if record.user_id == user.id
                user.restaurant_owner? || user.super_admin? || user.mod?
              end


end
