# frozen_string_literal: true

class OrderPolicy < ApplicationPolicy
  def index?
    user.is_Admin?
  end

  def edit?
    user.is_Admin?
  end

  def update?
    user.is_Admin?
  end

  def destroy?
    user.is_Admin?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
