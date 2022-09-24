//// This module contains some useful functions for working
//// with numbers.
////
//// For more information see [this website](https://example.com).

import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
}

// gleeunit test functions end in `_test`
pub fn hello_world_test() {
  1
  |> should.equal(1)
}
