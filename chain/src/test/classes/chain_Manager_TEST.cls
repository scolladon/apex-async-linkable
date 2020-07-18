@isTest
private class chain_Manager_TEST {
  private static final String EXECUTOR = 'chain_Manager_TEST';
  @isTest
  static void testAll() {
    chain_Manager aChainManager = new chain_Manager();

    aChainManager
    .Add(new chain_Method_TEST())
    .Add(new chain_Batch_TEST())
    .Add(new chain_Future_TEST())
    .Add(new chain_Schedule_TEST('test','0 0 * * * ?'))
    .Add(new chain_Future_TEST())
    .Add(new chain_Future_TEST())
    .Add(new chain_ScheduleBatch_TEST('test',1,1))
    .Add(new chain_Future_TEST())
    .Add(new chain_Queue_TEST())
    ;
    aChainManager.first(new chain_Method_TEST());
    aChainManager.last(new chain_Method_TEST());

    chain_Manager anotherChainManager = new chain_Manager(EXECUTOR);

    anotherChainManager
    .Add(new chain_Method_TEST())
    .Add(new chain_Batch_TEST())
    .Add(new chain_Future_TEST())
    .Add(new chain_Schedule_TEST('test','0 0 * * * ?'))
    .Add(new chain_Future_TEST())
    .Add(new chain_Future_TEST())
    .Add(new chain_ScheduleBatch_TEST('test',1,1))
    .Add(new chain_Future_TEST())
    .Add(new chain_Queue_TEST())
    ;
    anotherChainManager.first(new chain_Method_TEST());
    anotherChainManager.last(new chain_Method_TEST());

    aChainManager.add(aChainManager);
    aChainManager.add(anotherChainManager);

    test.startTest();
    aChainManager.spawnChain();
    anotherChainManager.spawnChain(EXECUTOR);
    test.stopTest();
  }
}