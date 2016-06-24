defmodule MazeTest do
  # this tests the maze loading components
  use ExUnit.Case
  doctest Mirrormaze

  test "it gets the next position from a previous one and a direction" do
    assert Maze.next_position({0, 1}, "S") == {0, 2}
    assert Maze.next_position({5, 1}, "N") == {5, 0}
    assert Maze.next_position({0, 1}, "E") == {1, 1}
    assert Maze.next_position({1, 1}, "W") == {0, 1}
  end

  test "it checks for out of bounds" do
    bounds = {5, 5}
    assert   Maze.out_of_bounds bounds, {6, 6}
    assert ! Maze.out_of_bounds bounds, {0, 0}
    assert   Maze.out_of_bounds bounds, {0, 6}
    assert   Maze.out_of_bounds bounds, {-1, 0}
    assert   Maze.out_of_bounds bounds, {0, -1}
    assert ! Maze.out_of_bounds bounds, {3, 4}
  end

  test "it checks if it has a mirror" do
    assert Maze.get_mirror({2, 2}, [ %{x: 2, y: 2, type: "\\"}]) == {:success, "\\"}
    assert Maze.get_mirror({2, 2}, [ %{x: 2, y: 3, type: "\\"}]) == {:fail}
  end

  test "solves for one by one" do
    maze = MazeLoader.load_file("./samples-data/single.dat")
    {:ok, {0, 0}, 0} == Maze.solve(maze)
  end

  test "solves for the standard case" do
    maze = MazeLoader.load_file("./samples-data/basic.dat")
    assert Maze.solve(maze) == {:ok, {1, 0}, 8}
  end

  test "it works with big files" do
    maze = MazeLoader.load_file("./samples-data/bigkahuna.dat")
    assert Maze.solve(maze) == {:ok, {999, 500}, 2495}
  end

  test "it detects cycles" do
    maze = MazeLoader.load_file("./samples-data/cycle.dat")
    assert Maze.solve(maze) == {:fail, "cycle detected"}
  end
  
end
