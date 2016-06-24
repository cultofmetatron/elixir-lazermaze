defmodule MazeLoader do
  @doc """
    Takes a filepath and loads in the contents of a file.
  """
  def load_raw(file_path) do
    {:ok, file} = File.read file_path
    file
  end

  # takes an array of mirrors and returns a list of mirrors with x, y and type
  # iex> extract_mirrors([["4", "5", "/"], ["2", "4", "\"])
  # [{x: 4, y: 5, m: "/"}, {x: 2, y: 4 m: "\\"}]
  defp extract_mirrors([_ | [_ | []]]), do: []
  defp extract_mirrors([_ | [_ | mirrors]]) do
    Enum.map mirrors, fn(mirror) ->
      # elem(Integer.parse(hd(mirror)), 0)
      %{
        x: mirror |> hd |> Integer.parse |> elem(0),
        y: mirror |> tl |> hd |> Integer.parse |> elem(0),
        type: mirror |> tl |> tl |> hd
      }
    end
  end

  #takes the dimmensions
  defp extract_dimension([dim | _ ]) do
    %{ 
      length: dim |> hd |> Integer.parse |> elem(0),
      width: dim |> tl |> hd |> Integer.parse |> elem(0)
    }
  end

  # extracts the start point and direction
  defp extract_start([_ | [ start | _ ]]) do
    %{
      x: start |> hd |> Integer.parse |> elem(0),
      y: start |> tl |> hd |> Integer.parse |> elem(0),
      direction: start |> tl |> tl |> hd
    }
  end

  @doc """
  Takes the contents and returns a maze spec

  iex> MazeLoader.extract_data "5 6\n1 4 S\n3 4 \/\n3 0 \/\n1 2 \\\n3 2 \\\n4 3 \\\n"
    %{mirrors: [%{type: "/", x: 3, y: 4}, %{type: "/", x: 3, y: 0},
      %{type: "\\", x: 1, y: 2}, %{type: "\\", x: 3, y: 2},
      %{type: "\\", x: 4, y: 3}], size: %{length: 5, width: 6},
     start: %{direction: "S", x: 1, y: 4}}
  """
  def extract_data(contents) do
    data = contents
      |> String.split("\n")
      |> Enum.filter(fn(str) -> str !== "" end) # remove empty newline without data
      |> Enum.map(fn(str)-> String.split(str, ~r/\s/) end)
    %{
      size: extract_dimension(data),
      start: extract_start(data),
      mirrors: extract_mirrors(data)
    }
  end

  @doc """
    Takes the file and returns a maze spec
  """
  def load_file(file), do: file |> load_raw |> extract_data

end
