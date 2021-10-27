class OrderPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
  # Repare que nossos metodos estão FORA da 'class Scope'
  # Mas estão dentro da class RestaurantPolicy

  def show?
    true
  end

  def new?
    true
  end

  def create?
    # Scenario hipotético levantado na aula
    # Se o nosso user tem uma column chamada 'role' as opções são, business_owner, business_employee, podemos fazer:
    # ['business_owner', 'business_employee'].include? user.role
    # OU
    # record.user.role == 'business_employee'

    ###############################
    ### UTILIZACAO REAL DA AULA ###
    ###############################
    true
  end

  def edit?
    update?
  end

  def update?
    user_role_allowed?
  end

  def destroy?
    user_role_allowed?
  end

  private

  def user_role_allowed?
    # @restaurant => record
    # current_user => user
    record.user == user
  end
end
