module AoC
  extend self

  def run_22_1a(input = AoC.input(22, 1))
    input.split("\n\n").map(&.split('\n').map(&.to_i).sum).max
  end

  def run_22_1b(input = AoC.input(22, 1))
    input.split("\n\n").map(&.split('\n').map(&.to_i).sum).sort[-3..].sum
  end
end
