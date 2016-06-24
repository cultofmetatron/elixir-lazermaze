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
      if (mirror[:x] == x && mirror[:y] == y) do
        { :success, mirror[:type] }
      else
        false
      end
    end) || { :fail }
  end

  def update_direction("S", "/"),   do: "W"
  def update_direction("S", "\\"),  do: "E"
  def update_direction("N", "/"),   do: "E"
  def update_direction("N", "\\"),  do: "W"
  def update_direction("E", "/"),   do: "N"
  def update_direction("E", "\\"),  do: "S"
  def update_direction("W", "/"),   do: "S"
  def update_direction("W", "\\"),  do: "N"

  # takes a list of position and returns true or false
  def in_path?(path, {x, y}, direction) do
    Enum.count(path, fn({x1, y1, dir1}) ->
      (x == x1 && y == y1 && direction == dir1)
    end) > 0
  end

  # starts with the basic maze and we track the position and path as we traverse
  def solver(size, mirrors, direction, position, count, path) do
    #IO.inspect({ size, mirrors, direction, position, count, path})
    # is there a mirror here? if yes we must changed the position accordingly
    new_direction = case get_mirror(position, mirrors) do
      {:success, mirror} -> update_direction(direction, mirror)
      {:fail } -> direction
    end
    next = next_position(position, new_direction)
    # get the next position and check if its out of bounds
    # Base case
    cond do
      # 1.  next position is out of bounds
      out_of_bounds(size, next) ->
        {:ok, position, count}
      # 2. next position is in the path with the same direction (infinite loop)
      in_path?(path, position, direction) ->
        {:fail, "cycle detected"}
      # Recursive step
      # 1. call with next position,
      true ->
        breadcrumb = { elem(position, 0), elem(position, 1), direction}
        solver(size, mirrors, new_direction, next, count + 1, [breadcrumb | path])
    end
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
  """
  def solve(maze) do
    #size, mirrors, direction, position, count, path
    size = { maze[:size][:width], maze[:size][:length] }
    position = {maze[:start][:x], maze[:start][:y] }
    direction = maze[:start][:direction]
    solver(size, maze[:mirrors], direction, position, 0, [])
  end

end
