class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    can :shopping_list, Food
    can :manage, Food, user_id: user.id
    can :manage, Recipe, user_id: user.id
    can :manage, RecipeFood, recipe: { user_id: user.id }
    can :show, Recipe
    can :read, Recipe, public: true
  end
end
