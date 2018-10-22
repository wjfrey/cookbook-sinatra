require 'csv'
require_relative 'recipe'

class Cookbook
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @recipes = []
    CSV.foreach(@csv_file_path) do |row|
      @recipes << Recipe.new(row[0], row[1], row[2], row[3], row[4] == "true")
    end
    puts @recipes
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    update_recipes
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    update_recipes
  end

  def toggle_done(index)
    @recipes[index].toggle_done
    update_recipes
  end

  def update_recipes
    CSV.open(@csv_file_path, 'wb') do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.preparation_time, recipe.difficulty, recipe.done]
      end
    end
  end
end
