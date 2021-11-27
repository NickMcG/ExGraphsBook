defmodule NativeGraph do

  ## GRAPH STORE

  use GraphCommons.Graph, graph_type: :native, graph_module: __MODULE__
  use GraphCommons.Query, query_type: :native, query_module: __MODULE__

  ## GRAPH SERVICE

  defdelegate graph_create(arg), to: NativeGraph.Service, as: :graph_create
  defdelegate graph_delete(), to: NativeGraph.Service, as: :graph_delete
  defdelegate graph_info(), to: NativeGraph.Service, as: :graph_info
  defdelegate graph_read(), to: NativeGraph.Service, as: :graph_read
  defdelegate graph_update(arg), to: NativeGraph.Service, as: :graph_update

  defdelegate query_graph(arg), to: NativeGraph.Service, as: :query_graph
  defdelegate query_graph!(arg), to: NativeGraph.Service, as: :query_graph!

  ## WRITE IMAGE

  defdelegate write_image(arg), to: NativeGraph.Format, as: :to_png
  defdelegate write_image(arg1, arg2), to: NativeGraph.Format, as: :to_png

  defdelegate random_graph(arg), to: NativeGraph.Builder, as: :random_graph

  defdelegate to_dot(arg), to: NativeGraph.Serializers.DOT, as: :serialize
  defdelegate to_dot!(arg), to: NativeGraph.Serializers.DOT, as: :serialize!

  def read_graph(graph_file), do:
    GraphCommons.Graph.read_graph(graph_file, :native)

  def write_graph(graph_data, graph_file), do:
    GraphCommons.Graph.write_graph(graph_data, graph_file, :native)

end
