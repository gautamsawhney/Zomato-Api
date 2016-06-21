class RestaurantPolicy < ApplicationPolicy

  # Autobot: Read Scope

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      raise Pundit::NotAuthorizedError, "" unless user 
      @user  = user
      @scope = scope
    end

    def resolve
      if user.restaurant_owner? || user.super_admin?
        scope.all
      else
        scope.none
      end
    end
  end

  # Autobot: Permitted Attributes
def permitted_attributes
                  #add_here
if user.restaurant_owner?
              [:name, :location, :user_id]
              elsif user.super_admin?
              [:name, :location, :user_id]
              else
                []
               end
                end



  # Autobot: Permitted Actions
def destroy?
                #return true if record.user_id == user.id
                user.super_admin?
              end
def update?
                #return true if record.user_id == user.id
                user.restaurant_owner? || user.super_admin?
              end
 def show?
                  user.restaurant_owner? || user.super_admin?
                end
def create?
                #return true if record.user_id == user.id
                user.restaurant_owner? || user.super_admin?
              end


end
