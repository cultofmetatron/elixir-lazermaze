defmodule MazeLoaderTest do
  # this tests the maze loading components
  use ExUnit.Case
  doctest Mirrormaze

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "it loads the raw file" do
    file = MazeLoader.load_raw("./samples-data/basic.dat")
    file_contents = "5 6\n1 4 S\n3 4 \/\n3 0 \/\n1 2 \\\n3 2 \\\n4 3 \\\n"
    IO.puts file_contents
    assert file == file_contents
  end

  
end
