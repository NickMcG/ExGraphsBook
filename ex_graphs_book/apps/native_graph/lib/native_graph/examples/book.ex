defmodule NativeGraph.Examples.Book do
  def book(use_id? \\ true), do: do_books(false, use_id?)

  def books(use_id? \\ true), do: do_books(true, use_id?)

  defp do_books(all_books?, use_id?) do
    # function to select id/map based on use_id? setting
    val = fn map -> if use_id?, do: map.id, else: map end

    # book 1
    bk1 =
      val.(%{
        id: :adopting_elixir,
        iri: "urn:isbn:978-1-68050-252-7",
        date: "2018-03-14",
        format: "Paper",
        title: "Adopting Elixir"
      })

    bk1_au1 =
      val.(%{
        id: :ben_marx,
        iri: "https://twitter.com/bgmarx",
        name: "Ben Marx"
      })

    bk1_au2 =
      val.(%{
        id: :jose_valim,
        iri: "https://twitter.com/josevalim",
        name: "José Valim"
      })

    bk1_au3 =
      val.(%{
        id: :bruce_tate,
        iri: "https://twitter.com/redrapids",
        name: "Bruce Tate"
      })

    bk1_pub =
      val.(%{
        id: :pragmatic,
        iri: "https://pragprog.com/",
        name: "The Pragmatic Bookshelf"
      })

    # book 2
    bk2 =
      val.(%{
        id: :graphql_apis,
        iri: "urn:isbn:978-1-68050-255-8",
        date: "2018-03-27",
        format: "Paper",
        title: "Craft GraphQL APIs in Elixir with Absinthe"
      })

    bk2_au1 =
      val.(%{
        id: :bruce_williams,
        iri: "https://twitter.com/wbruce",
        name: "Bruce Williams"
      })

    bk2_au2 =
      val.(%{
        id: :ben_wilson,
        iri: "https://twitter.com/benwilson512",
        name: "Ben Wilson"
      })

    bk2_pub =
      val.(%{
        id: :pragmatic,
        iri: "https://pragprog.com/",
        name: "The Pragmatic Bookshelf"
      })

    # book 3
    bk3 =
      val.(%{
        id: :designing_elixir,
        iri: "urn:isbn:978-1-68050-661-7",
        date: "2019-11-20",
        format: "Paper",
        title: "Designing Elixir Systems with OTP"
      })

    bk3_au1 =
      val.(%{
        id: :james_gray,
        iri: "https://twitter.com/JEG2",
        name: "James Edward Gray II"
      })

    bk3_au2 =
      val.(%{
        id: :bruce_tate,
        iri: "https://twitter.com/redrapids",
        name: "Bruce Tate"
      })

    bk3_pub =
      val.(%{
        id: :pragmatic,
        iri: "https://pragprog.com/",
        name: "The Pragmatic Bookshelf"
      })

    # book 4
    bk4 =
      val.(%{
        id: :graph_algorithms,
        iri: "urn:isbn:978-1-492-04767-4",
        date: "2019-03-16",
        format: "Paper",
        title: "Graph Algorithms"
      })

    bk4_au1 =
      val.(%{
        id: :amy_hodler,
        iri: "https://twitter.com/amyhodler",
        name: "Amy E. Hodler"
      })

    bk4_au2 =
      val.(%{
        id: :mark_needham,
        iri: "https://twitter.com/markhneedham",
        name: "Mark Needham"
      })

    bk4_pub =
      val.(%{
        id: :oreilly,
        iri: "https://www.oreilly.com/",
        name: "O'Reilly Media"
      })

    # build graph
    g =
      Graph.new(type: :directed)
      #
      |> Graph.add_vertex(bk1, "Book")
      |> Graph.add_vertex(bk1_au1, "Author")
      |> Graph.add_vertex(bk1_au2, "Author")
      |> Graph.add_vertex(bk1_au3, "Author")
      |> Graph.add_vertex(bk1_pub, "Publisher")
      |> Graph.add_edge(bk1_pub, bk1, label: "BOOK")
      |> Graph.add_edge(bk1, bk1_au1, label: "AUTHOR")
      |> Graph.add_edge(bk1, bk1_au2, label: "AUTHOR")
      |> Graph.add_edge(bk1, bk1_au3, label: "AUTHOR")
      |> Graph.add_edge(bk1, bk1_pub, label: "PUBLISHER")

    g =
      if all_books? do
        g
        |> Graph.add_vertex(bk2, "Book")
        |> Graph.add_vertex(bk2_au1, "Author")
        |> Graph.add_vertex(bk2_au2, "Author")
        |> Graph.add_vertex(bk2_pub, "Publisher")
        |> Graph.add_edge(bk2_pub, bk2, label: "BOOK")
        |> Graph.add_edge(bk2, bk2_au1, label: "AUTHOR")
        |> Graph.add_edge(bk2, bk2_au2, label: "AUTHOR")
        |> Graph.add_edge(bk2, bk2_pub, label: "PUBLISHER")
        #
        |> Graph.add_vertex(bk3, "Book")
        |> Graph.add_vertex(bk3_au1, "Author")
        |> Graph.add_vertex(bk3_au2, "Author")
        |> Graph.add_vertex(bk3_pub, "Publisher")
        |> Graph.add_edge(bk3_pub, bk3, label: "BOOK")
        |> Graph.add_edge(bk3, bk3_au1, label: "AUTHOR")
        |> Graph.add_edge(bk3, bk3_au2, label: "AUTHOR")
        |> Graph.add_edge(bk3, bk3_pub, label: "PUBLISHER")
        #
        |> Graph.add_vertex(bk4, "Book")
        |> Graph.add_vertex(bk4_au1, "Author")
        |> Graph.add_vertex(bk4_au2, "Author")
        |> Graph.add_vertex(bk4_pub, "Publisher")
        |> Graph.add_edge(bk4_pub, bk4, label: "BOOK")
        |> Graph.add_edge(bk4, bk4_au1, label: "AUTHOR")
        |> Graph.add_edge(bk4, bk4_au2, label: "AUTHOR")
        |> Graph.add_edge(bk4, bk4_pub, label: "PUBLISHER")
      else
        g
      end

    g
  end
end
