DIFFICULTY = {
  "1" => "Très facile",
  "2" => "Facile",
  "3" => "Niveau moyen",
  "4" => "Difficile",
}


class Recipe
  attr_accessor :name, :description, :preparation_time, :difficulty, :done
  def initialize(name, description, preparation_time = "not available", difficulty = "n", done = false)
    @name = name
    @description = description
    @preparation_time = preparation_time
    @difficulty = convert_difficulty(difficulty)
    @done = done
  end

  def toggle_done
    @done = !@done
  end

  def convert_difficulty(difficulty)
    if difficulty == "n"
      "non given"
    elsif DIFFICULTY.key?(difficulty.to_s)
      DIFFICULTY[difficulty]
    else
      difficulty
    end
  end
end
