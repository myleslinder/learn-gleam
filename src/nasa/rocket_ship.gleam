import gleam/string_builder
import gleam/int

// Elixir modules start with `Elixir.`
// Can only use this if in Elixir
// external fn inspect(a) -> a =
//   "Elixir.IO" "inspect"

pub external fn random_float() -> Float =
  "rand" "uniform"

fn count_down(str: string_builder.StringBuilder, from start: Int) -> String {
  case start {
    0 ->
      str
      |> string_builder.append("BOOM!")
      |> string_builder.to_string
    n ->
      str
      |> string_builder.append(int.to_string(start))
      |> string_builder.append("...")
      |> count_down(n - 1)
  }
}

pub fn elixir_inspect() {
  //   inspect("This is from Elixir!")
  random_float()
}

fn blast_off() {
  "BOOM!"
}

pub fn launch() {
  [
    string_builder.new()
    |> count_down(10),
    blast_off(),
  ]
}
