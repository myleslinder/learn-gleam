import gleam/int.{compare}
import gleam/order
import gleam/list.{reverse}

pub type Range {
  Range(from: Int, to: Int, list: List(Int))
}

/// alias
pub type Headers =
  List(#(String, String))

pub fn forward_range(from from: Int, to to: Int) -> Result(Range, String) {
  case from, to {
    start, stop if start > stop -> Error("from is greater than to")
    start, stop -> Ok(range_recurse(start, stop, Range(start, stop, [])))
  }
}

pub fn any_range(from from: Int, to to: Int) -> List(Int) {
  range_recurse(from, to, Range(from, to, [])).list
}

fn range_recurse(start: Int, stop: Int, acc: Range) -> Range {
  case compare(start, stop) {
    order.Eq -> Range(..acc, list: reverse([stop, ..acc.list]))
    order.Gt ->
      range_recurse(start - 1, stop, Range(..acc, list: [start, ..acc.list]))
    order.Lt ->
      range_recurse(start + 1, stop, Range(..acc, list: [start, ..acc.list]))
  }
}

pub const x: Int = 5
