use aiken/fuzz
use modules/functions.{increment}

test increment_test() {
  // ? operator
  and {
    (increment(1, Some(2)) == 3)?,
    (increment(2, Some(3)) == 5)?,
    (increment(3, Some(4)) == 7)?,
    (increment(4, None) == 5)?,
  }
}

/// Testing failure
test test_fail() fail {
  expect 5 = increment(3, None)
}

/// Property testing
///
/// Testing failure:
/// - fail (if it runs 100x, then ALL 100x it must fail) -> PASS
/// - fail once (not ALL fail) -> PASS
test increment_property_test(
  ls: List<Int> via fuzz.list_between(fuzz.int(), 2, 2),
) fail once {
  expect [n, step] = ls

  increment(n, Some(step)) > n
}
