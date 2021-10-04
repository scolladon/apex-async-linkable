public class AccountTriggerHandlerSimple {
  static final String EXECUTOR = 'AccountTriggerHandlerSimple';
  public static void handleTrigger(
    final List<Account> news,
    final List<Account> olds,
    final Trigger.OperationType opType
  ) {
    if (Trigger.operationType == BEFORE_UPDATE) {
      chain_Manager.instance.registerExecutor(EXECUTOR);
      AccountServiceSimple.handleUpdate(news);
    } else if (Trigger.operationType == AFTER_UPDATE) {
      AccountServiceSimple.handleSharing(news);
      chain_Manager.instance.spawnChain(EXECUTOR);
    }
  }
}
