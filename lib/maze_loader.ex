defmodule MazeLoader do
  @doc """
    Takes a filepath and loads in the contents of a file.
  """
  def load_raw(file_path) do
    {:ok, file} = File.read file_path
    file
  end
end
