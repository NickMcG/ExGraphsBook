defmodule GraphCommons.Query do

  ## ATTRIBUTES

  @storage_dir GraphCommons.storage_dir()

  ## STRUCT

  @derive {Inspect, except: [:path, :uri]}

  @enforce_keys ~w[data file type]a
  defstruct ~w[data file path type uri]a

  ## TYPES

  @type query_data :: String.t()
  @type query_file :: String.t()
  @type query_path :: String.t()
  @type query_type :: GraphCommons.query_type()
  @type query_uri :: String.t()

  @type t :: %__MODULE__{
          # user
          data: query_data,
          file: query_file,
          type: query_type,
          # system
          path: query_path,
          uri: query_uri
        }

  defguard is_query_type(query_type)
           when query_type in [ :dgraph, :native, :property, :rdf, :tinker ]

  ## CONSTRUCTOR

  def new(query_data, query_file, query_type)
      when is_query_type(query_type) do
    query_path = "#{@storage_dir}/#{query_type}/queries/#{query_file}"

    %__MODULE__{
      # user
      data: query_data,
      file: query_file,
      type: query_type,
      # system
      path: query_path,
      uri: "file://" <> query_path
    }
  end

  ## FUNCTIONS

  def queries_dir(query_type), do: "#{@storage_dir}/#{query_type}/queries/"

  @type file_test :: GraphCommons.file_test()

  def list_queries(query_type, file_test \\ :exists?) do
    list_queries_dir("", query_type, file_test)
  end

  def list_queries_dir(query_file, query_type, file_test \\ :exists?) do
    path = "#{@storage_dir}/#{query_type}/queries/"

    (path <> query_file)
    |> File.ls!()
    |> do_filter(path, file_test)
    |> Enum.sort()
    |> Enum.map(fn f ->
      File.dir?(path <> f)
      |> case do
        true -> "#{String.upcase(f)}"
        false -> f
      end
    end)
  end

  defp do_filter(files, path, file_test) do
    files
    |> Enum.filter(fn f ->
      case file_test do
        :dir? -> File.dir?(path <> f)
        :regular? -> File.regular?(path <> f)
        :exists? -> true
      end
    end)
  end

  def read_query(query_file, query_type)
      when query_file != "" and is_query_type(query_type) do
    queries_dir = "#{@storage_dir}/#{query_type}/queries/"
    query_data = File.read!(queries_dir <> query_file)

    new(query_data, query_file, query_type)
  end

  def write_query(query_data, query_file, query_type)
      when query_data != "" and
             query_file != "" and is_query_type(query_type) do
    queries_dir = "#{@storage_dir}/#{query_type}/queries/"
    File.write!(queries_dir <> query_file, query_data)

    new(query_data, query_file, query_type)
  end

  ## IMPLEMENTATIONS

  defimpl Inspect, for: __MODULE__ do
    @slice 16
    @quote <<?">>

    def inspect(%GraphCommons.Query{} = query, _opts) do
      type = query.type
      file = @quote <> query.file <> @quote

      str =
        query.data
        |> String.replace("\n", "\\n")
        |> String.replace(@quote, "\\" <> @quote)
        |> String.slice(0, @slice)

      data =
        case String.length(str) < @slice do
          true -> @quote <> str <> @quote
          false -> @quote <> str <> "..." <> @quote
        end

      "#GraphCommons.Query<type: #{type}, file: #{file}, data: #{data}>"
    end
  end

end
