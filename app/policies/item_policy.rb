class ItemPolicy < ApplicationPolicy
  def new?
    user.is_Admin?
  end

  def create?
    user.is_Admin?
  end

  def edit?
    user.is_Admin?
  end

  def destroy?
    user.is_Admin?
  end

  class Scope < Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.is_Admin?
        scope.all
      else
        scope.where(flag: true)
      end
    end

    private

    attr_reader :user, :scope
  end
end
