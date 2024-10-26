use cardano/assets.{PolicyId}
use cardano/script_context.{Publishing, ScriptContext, Withdrawing}
use cardano/transaction.{Transaction}

validator td {
  mint(redeemer: Int, _policy_id: PolicyId, _tx: Transaction) {
    // IF the redeemer is NOT 42
    // THEN it will print:
    // ```
    // Redeemer: redeemer_value
    // redeemer == 42 ? False
    // ```
    trace @"Redeemer": redeemer
    (redeemer == 42)?
  }

  /// ScriptContext {
  ///   transaction: Transaction,
  ///   redeemer: Redeemer,
  ///   info: ScriptInfo
  /// }
  else(ctx: ScriptContext) {
    // kinda like switch-case
    when ctx.info is {
      Withdrawing { .. } | Publishing { .. } -> True
      _ -> fail @"Unsupported"
    }
  }

  // PlutusV3
  // allValidator(ScriptContext)

  // PlutusV1/V2
  // spending(datum, redeemer, ScriptContext)
  // anyOther(redeemer, ScriptContext)
}
