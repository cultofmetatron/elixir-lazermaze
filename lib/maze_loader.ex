defmodule MazeLoader do
  @doc """
    Takes a filepath and loads in the contents of a file.
  """
  def load_raw(file_path) do
    {:ok, file} = File.read file_path
    file
  end

  @doc """
    takes an array of mirrors and returns a list of mirrors with x, y and type
    iex> process_mirrors([["4", "5", "/"], ["2", "4", "\"])
    [{x: 4, y: 5, m: "/"}, {x: 2, y: 4 m: "\\"}]
  """
  def process_mirrors(mirrors) do
    mirrors
  end

  #takes the dimmensions
  defp extract_dimension(data) do
    [dim | _ ] = data
    %{ 
      length: dim |> hd |> Integer.parse |> elem(0),
      width: dim |> tl |> hd |> Integer.parse |> elem(0)
    }
  end

  # extracts the start point and direction
  defp extract_start(data) do
    [_ | [ strt | _ ]] = data
    %{
      x: strt |> hd |> Integer.parse |> elem(0),
      y: strt |> tl |> hd |> Integer.parse |> elem(0),
      direction: strt |> tl |> tl |> hd
    }
  end

  @doc """
    Takes the contents and returns a maze spec
  """
  def extract_data(contents) do
    data = String.split(contents, "\n")
      |> Enum.filter(fn(str) -> str !== "" end)
      |> Enum.map(fn(str)-> String.split(str, ~r/\s/) end)
    %{
      size: extract_dimension(data),
      start: extract_start(data)
    }
  end

end
