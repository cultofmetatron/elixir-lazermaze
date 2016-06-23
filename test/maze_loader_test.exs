defmodule MazeLoaderTest do
  # this tests the maze loading components
  use ExUnit.Case
  #doctest MazeLoader

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "it loads the raw file" do
    file = MazeLoader.load_raw("./samples-data/basic.dat")
    file_contents = "5 6\n1 4 S\n3 4 \/\n3 0 \/\n1 2 \\\n3 2 \\\n4 3 \\\n"
    assert file == file_contents
  end

  test "it returns a processed file" do
    file = MazeLoader.load_raw("./samples-data/basic.dat")
    data = MazeLoader.extract_data(file)
    assert data == %{
      size: %{length: 5, width: 6},
      start: %{direction: "S", x: 1, y: 4},
      mirrors: [
        %{type: "/", x: 3, y: 4},
        %{type: "/", x: 3, y: 0},
        %{type: "\\", x: 1, y: 2},
        %{type: "\\", x: 3, y: 2},
        %{type: "\\", x: 4, y: 3}
      ]
    }
  end

  
  test "load_file loads and returns a processed file" do
    #file = MazeLoader.load_raw("./samples-data/basic.dat")
    data = MazeLoader.load_file("./samples-data/basic.dat")
    assert data == %{
      size: %{length: 5, width: 6},
      start: %{direction: "S", x: 1, y: 4},
      mirrors: [
        %{type: "/", x: 3, y: 4},
        %{type: "/", x: 3, y: 0},
        %{type: "\\", x: 1, y: 2},
        %{type: "\\", x: 3, y: 2},
        %{type: "\\", x: 4, y: 3}
      ]
    }

  end

  test "it should return an empty array for no mirrors" do
    data = MazeLoader.load_file("./samples-data/single.dat")
    assert data == %{
      size: %{length: 1, width: 1},
      start: %{direction: "S", x: 0, y: 0},
      mirrors: []
    }
  end


  
end
