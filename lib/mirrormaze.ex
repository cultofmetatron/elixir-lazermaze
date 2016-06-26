defmodule Mirrormaze do

  def solve(file_name) do
    output = file_name
      |> MazeLoader.load_file()
      |> Maze.solve()
    IO.inspect(output)
  end

end
