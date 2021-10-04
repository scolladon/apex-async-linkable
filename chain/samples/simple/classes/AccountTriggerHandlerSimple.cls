public class AccountTriggerHandlerSimple {
  static final String EXECUTOR = 'AccountTriggerHandlerSimple';
  public static void handleTrigger(
    final List<Account> news,
    final List<Account> olds,
    final System.TriggerOperation triggerEvent
  ) {
    if (triggerEvent == TriggerOperation.BEFORE_UPDATE) {
      chain_Manager.instance.registerExecutor(EXECUTOR);
      AccountServiceSimple.handleUpdate(news);
    } else if (triggerEvent == TriggerOperation.AFTER_UPDATE) {
      AccountServiceSimple.handleSharing(news);
      chain_Manager.instance.spawnChain(EXECUTOR);
    }
  }
}
