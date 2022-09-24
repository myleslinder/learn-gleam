import gleam/io
import gleam/string_builder
import gleam/string.{reverse}
import gleam/int.{to_string}
import gleam/float.{to_string as float_str}
import gleam/list
import nasa/rocket_ship.{elixir_inspect, launch}
import range.{Range, any_range, forward_range}

// Can only import Js if compiling to JS
// external fn runn() -> Float =
//   "./js/my-module.mjs" "runn"

pub fn main() {
  io.println(reverse_and_new(reverse: "Hello from first_gleam!").0)
  io.println(to_string(run()))

  list.each(launch(), io.println)
  any_range(2, 1)
  |> list.map(to_string)
  |> list.each(io.println)

  case forward_range(1, 10) {
    Ok(x) ->
      x.list
      |> list.map(to_string)
      |> list.each(io.println)
    Error(x) -> io.println(x)
  }
  io.println(float_str(elixir_inspect()))
}

pub fn triable() -> Result(Range, String) {
  try z = forward_range(1, 2)
  z.list
  |> list.map(to_string)
  |> list.each(io.println)
  assert Ok(_) = forward_range(1, 2)
  Ok(z)
}

pub fn never_going_to_implement() -> String {
  // io.println(todo("this is a neat feature"))
  ""
}

pub fn handle() {
  let fahrenheit = [1]
  // Names can be reused by later let bindings, .. is spread
  let fahrenheit = [2, ..fahrenheit]
  // Block is an expression
  let f = {
    let v = 32
    let [t, ..] = fahrenheit
    t - v
  }
  // block expression can replace parens
  let celsius = { f - 32 + 32 } * 5 / 9
  celsius
}

/// Calls a function for each element in a list, discarding the results.
pub fn my_each(list: List(a), f: fn(a) -> b) -> Nil {
  case list {
    [] -> Nil
    [val, ..rest] -> {
      f(val)
      my_each(rest, f)
    }
  }
}

pub fn my_tuple(n: Int) -> String {
  // Tuple, heterogeneous array of defined length
  // accessed with dot syntax
  #(n, "hello").1
}

pub fn case_matcher(some_number: Int, other_num: Int) -> #(List(Int), String) {
  let v = case some_number, other_num {
    0, 0 -> "Zero"
    1, 1 -> "One"
    2, 2 -> "Two"
    3, 4 | 4, 5 -> "wooow"
    // This matches anything
    n, nn if n > 5 && nn < 10 -> "this"
    q, qq ->
      case q, qq {
        5, 10 -> "this"
        // As does this
        _, __ -> "Some other number"
      }
  }
  #([some_number, other_num], v)
}

/// This function takes a function as an argument
/// It's generic because it calls any function twice
/// not just the case of this int function we have
/// in the example
fn twice(f: fn(t) -> t, x: t) -> t {
  f(f(x))
}

fn add(x: Int, y: Int) -> Int {
  x + y
}

fn add_one(x: Int) -> Int {
  add(x, 1)
}

fn add_two(x: Int) -> Int {
  twice(add_one, x)
}

fn adder(y: Int) -> fn(Int) -> Int {
  fn(x: Int) { x + y }
}

pub fn reverse_and_new(reverse s: String) -> #(String, String) {
  // is same as: string_builder.to_string(string_builder.reverse(string_builder.new()))
  let n =
    string_builder.new()
    |> string_builder.reverse
    |> string_builder.to_string

  #(reverse(s), n)
}

pub fn run() -> Int {
  let add_six = add(_, 6)
  fn(x, y) { x + y }(1, _)(2)
  |> add_one
  |> add(1)
  |> add(6)
  |> add_two
  |> adder(3)
  |> add_one
  |> add_one
  |> add_six
}
