require "../spec_helper"

describe "AoC" do
  describe "22" do
    describe "1" do
      input = <<-INPUT
      1000
      2000
      3000
      
      4000
      
      5000
      6000
      
      7000
      8000
      9000
      
      10000
      INPUT

      describe "a" do
        it "passes example" do
          AoC.run_22_1a(input).should eq(24000)
        end
      end

      describe "b" do
        it "passes example" do
          AoC.run_22_1b(input).should eq(45000)
        end
      end
    end
  end
end
