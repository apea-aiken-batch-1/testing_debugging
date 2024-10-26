use aiken/collection/list
use aiken/crypto.{VerificationKeyHash}
use cardano/transaction.{OutputReference, Transaction}

validator spd(param_1 pkh: VerificationKeyHash) {
  spend(
    datum _datum: Option<Data>,
    redeemer _redeemer: Int,
    oref _oref: OutputReference,
    tx: Transaction,
  ) {
    list.has(tx.extra_signatories, pkh)
  }

  else(_) {
    fail
  }
}

test spd_test_1() {
  spd.spend(
    param_1: "PKH",
    datum: None,
    redeemer: 0,
    oref: OutputReference { transaction_id: "", output_index: 0 },
    tx: Transaction { ..transaction.placeholder, extra_signatories: ["PKH"] },
  )
}
