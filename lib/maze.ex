defmodule Maze do

  #gives the next pointer on the screen
  def next_position(position, direction \\ "S")
  def next_position({ x, y }, "N"), do: { x, y - 1 }
  def next_position({ x, y }, "S"), do: { x, y + 1 }
  def next_position({ x, y }, "E"), do: { x + 1, y }
  def next_position({ x, y }, "W"), do: { x - 1, y }

  def out_of_bounds({ l, w }, {x, y}) do
    (x >= l) || (y >= w) || (x < 0) || (y < 0)
  end

  # given a set of mirrors, return the mirror type or fail
  # { :success, "/" }
  # { :fail }
  def get_mirror({x, y}, mirrors) do
    Enum.find_value(mirrors, fn(mirror) ->
      IO.inspect(mirror)
      if (mirror[:x] == x && mirror[:y] == y) do
        { :success, mirror[:type] }
      else
        false
      end
    end) || { :fail }
  end


  # starts with the basic maze and we track the position and path as we traverse
  def solver(mirrors, position, count, path) do
    
  end

    @doc """
    takes a maze and solves it
    
    A maze is a map with a size, start and set of mirrors
    maze = %{
      size: %{length: 5, width: 6},
      start: %{direction: "S", x: 1, y: 4},
      mirrors: [
        %{type: "/", x: 3, y: 4},
        %{type: "\", x: 3, y: 0},
      ]
    }
    Maze.solve(maze)
    { :success, %{
        squares: 0,
        exit_square: { 3, 5 }
      }
    }
  """
  def solve(maze) do
    {}
  end

end
