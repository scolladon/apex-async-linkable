@isTest
private class chain_Manager_TEST {
  private static final String EXECUTOR = 'chain_Manager_TEST';

  @isTest
  static void testAll() {
    final chain_Manager aChainManager = new chain_Manager(EXECUTOR);

    aChainManager
      .add(new chain_Batch_TEST())
      .add(new chain_Future_TEST())
      .add(new chain_Schedule_TEST('test schedule 1', '0 0 * * * ?'))
      .add(new chain_Future_TEST())
      .add(new chain_Future_TEST())
      .add(new chain_ScheduleBatch_TEST('test schedule batch 1', 1))
      .add(new chain_Future_TEST())
      .add(new chain_Queue_TEST());

    final chain_Manager anotherChainManager = new chain_Manager(EXECUTOR);

    final chain_Chainable chainBatch = new chain_Batch_TEST();
    chainBatch.setNext(new chain_Future_TEST());

    anotherChainManager
      .add(chainBatch)
      .add(new chain_Schedule_TEST('test schedule 2', '0 0 * * * ?'))
      .add(new chain_Future_TEST())
      .add(new chain_Future_TEST())
      .add(new chain_ScheduleBatch_TEST('test schedule batch 2', 1))
      .add(new chain_Future_TEST())
      .add(new chain_Queue_TEST());

    aChainManager.add(anotherChainManager);

    final chain_Manager emptyChainManager = new chain_Manager();

    test.startTest();
    emptyChainManager.spawnChain();
    aChainManager.spawnChain();
    aChainManager.spawnChain('random');
    Id jobId1 = aChainManager.spawnChain(EXECUTOR);
    test.stopTest();

    System.assertNotEquals(null, jobId1, 'Job should be spawn: ' + jobId1);
  }

  @isTest
  static void testAddLink() {
    final chain_Manager chainManager = new chain_Manager(EXECUTOR);
    final chain_Chainable chainBatch = new chain_Batch_TEST();
    chainBatch.setNext(new chain_Future_TEST());
    chain_Chainable nullChainable = null;

    test.startTest();
    chainManager.add(nullChainable);
    chainManager.add(chainBatch);
    test.stopTest();

    System.assertEquals(
      chainBatch,
      chain_Manager.unchain(chainManager)[0],
      'First element of the chain should be ' + chainBatch
    );
  }

  @isTest
  static void testAddManager() {
    final chain_Manager chainManager = new chain_Manager(EXECUTOR);
    final chain_Manager chainManager2 = new chain_Manager();
    final chain_Chainable chainBatch = new chain_Batch_TEST();
    chainBatch.setNext(new chain_Future_TEST());
    chainManager2.add(chainBatch);
    chain_Manager nullCM = null;

    test.startTest();
    chainManager.add(nullCM);
    chainManager.add(chainManager2);
    test.stopTest();

    System.assertEquals(
      chainBatch,
      chain_Manager.unchain(chainManager)[0],
      'First element of the chain should be ' + chainBatch
    );
  }

  @isTest
  static void testAddLinks() {
    final chain_Manager chainManager = new chain_Manager(EXECUTOR);
    final chain_Chainable chainBatch = new chain_Batch_TEST();
    final chain_Chainable[] chains = new List<chain_Chainable>{
      chainBatch,
      new chain_Future_TEST()
    };
    final chain_Chainable[] nullChains = null;

    test.startTest();
    chainManager.add(nullChains);
    chainManager.add(chains);
    test.stopTest();

    System.assertEquals(
      chainBatch,
      chain_Manager.unchain(chainManager)[0],
      'First element of the chain should be ' + chainBatch
    );
  }

  @isTest
  static void testAddManagers() {
    final chain_Manager chainManager = new chain_Manager(EXECUTOR);
    final chain_Manager chainManager2 = new chain_Manager();
    final chain_Chainable chainBatch = new chain_Batch_TEST();
    chainBatch.setNext(new chain_Future_TEST());
    chainManager2.add(chainBatch);
    final chain_Manager[] chains = new List<chain_Manager>{
      chainManager2,
      new chain_Manager()
    };
    chain_Manager[] nullCM = null;

    test.startTest();
    chainManager.add(nullCM);
    chainManager.add(chains);
    test.stopTest();

    System.assertEquals(
      chainBatch,
      chain_Manager.unchain(chainManager)[0],
      'First element of the chain should be ' + chainBatch
    );
  }

  @isTest
  static void testGetLastLink() {
    final chain_Chainable chainFuture = new chain_Future_TEST();
    final chain_Chainable chainBatch = new chain_Batch_TEST();
    chainFuture.setNext(chainBatch);

    test.startTest();
    final chain_Chainable lastLink = chain_Manager.getLastLink(chainFuture);
    test.stopTest();

    System.assertEquals(
      chainBatch,
      lastLink,
      'Last element of the chain should be ' + chainBatch
    );
    System.assertEquals(
      null,
      chain_Manager.getLastLink(null),
      'getLastLink should return null with null'
    );
  }

  @isTest
  static void testUnchainManager() {
    final chain_Manager chainManager = new chain_Manager(EXECUTOR);
    final chain_Chainable chain = new chain_Future_TEST();
    chain.setNext(new chain_Batch_TEST());
    chainManager.add(chain);

    test.startTest();
    final chain_Chainable[] links = chain_Manager.unchain(chainManager);
    test.stopTest();

    System.assertEquals(
      chain,
      links[0],
      'First element of the chain should be ' + chain
    );
    System.assertEquals(2, links.size(), 'Size of links should be 2');
  }

  @isTest
  static void testUnchainLink() {
    final chain_Chainable chain = new chain_Future_TEST();
    chain.setNext(new chain_Batch_TEST());

    test.startTest();
    final chain_Chainable[] links = chain_Manager.unchain(chain);
    test.stopTest();

    System.assertEquals(
      chain,
      links[0],
      'First element of the chain should be ' + chain
    );
    System.assertEquals(2, links.size(), 'Size of links should be 2');
  }
}
