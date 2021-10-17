@isTest
private class ChainManagerTest {
  private static final String EXECUTOR = 'ChainManagerTest';

  @isTest
  static void testAll() {
    final ChainManager aChainChainManager = new ChainManager(EXECUTOR);

    aChainChainManager
      .add(new BatchLinkTest())
      .add(new FutureLinkTest())
      .add(new ScheduleLinkTest('test ScheduleLink 1', '0 0 * * * ?'))
      .add(new FutureLinkTest())
      .add(new FutureLinkTest())
      .add(new ScheduleBatchLinkTest('test ScheduleLink BatchLink 1', 1))
      .add(new FutureLinkTest())
      .add(new QueueLinkTest());

    final ChainManager anotherChainChainManager = new ChainManager(EXECUTOR);

    final AsyncLinkable chainBatchLink = new BatchLinkTest();
    chainBatchLink.setNext(new FutureLinkTest());

    anotherChainChainManager
      .add(chainBatchLink)
      .add(new ScheduleLinkTest('test ScheduleLink 2', '0 0 * * * ?'))
      .add(new FutureLinkTest())
      .add(new FutureLinkTest())
      .add(new ScheduleBatchLinkTest('test schedule BatchLink 2', 1))
      .add(new FutureLinkTest())
      .add(new QueueLinkTest());

    aChainChainManager.add(anotherChainChainManager);

    final ChainManager emptyChainChainManager = new ChainManager();

    test.startTest();
    emptyChainChainManager.startChain();
    aChainChainManager.startChain();
    aChainChainManager.startChain('random');
    Id jobId1 = aChainChainManager.startChain(EXECUTOR);
    test.stopTest();

    System.assertNotEquals(null, jobId1, 'Job should be spawn: ' + jobId1);
  }

  @isTest
  static void testAddLink() {
    final ChainManager chainChainManager = new ChainManager(EXECUTOR);
    final AsyncLinkable chainBatchLink = new BatchLinkTest();
    chainBatchLink.setNext(new FutureLinkTest());
    AsyncLinkable nullAsyncLinkable = null;

    test.startTest();
    chainChainManager.add(nullAsyncLinkable);
    chainChainManager.add(chainBatchLink);
    test.stopTest();

    System.assertEquals(
      chainBatchLink,
      ChainManager.unchain(chainChainManager)[0],
      'First element of the chain should be ' + chainBatchLink
    );
  }

  @isTest
  static void testAddChainManager() {
    final ChainManager chainChainManager = new ChainManager(EXECUTOR);
    final ChainManager chainChainManager2 = new ChainManager();
    final AsyncLinkable chainBatchLink = new BatchLinkTest();
    chainBatchLink.setNext(new FutureLinkTest());
    chainChainManager2.add(chainBatchLink);
    ChainManager nullCM = null;

    test.startTest();
    chainChainManager.add(nullCM);
    chainChainManager.add(chainChainManager2);
    test.stopTest();

    System.assertEquals(
      chainBatchLink,
      ChainManager.unchain(chainChainManager)[0],
      'First element of the chain should be ' + chainBatchLink
    );
  }

  @isTest
  static void testAddLinks() {
    final ChainManager chainChainManager = new ChainManager(EXECUTOR);
    final AsyncLinkable chainBatchLink = new BatchLinkTest();
    final AsyncLinkable[] chains = new List<AsyncLinkable>{
      chainBatchLink,
      new FutureLinkTest()
    };
    final AsyncLinkable[] nullChains = null;

    test.startTest();
    chainChainManager.add(nullChains);
    chainChainManager.add(chains);
    test.stopTest();

    System.assertEquals(
      chainBatchLink,
      ChainManager.unchain(chainChainManager)[0],
      'First element of the chain should be ' + chainBatchLink
    );
  }

  @isTest
  static void testAddChainManagers() {
    final ChainManager chainChainManager = new ChainManager(EXECUTOR);
    final ChainManager chainChainManager2 = new ChainManager();
    final AsyncLinkable chainBatchLink = new BatchLinkTest();
    chainBatchLink.setNext(new FutureLinkTest());
    chainChainManager2.add(chainBatchLink);
    final ChainManager[] chains = new List<ChainManager>{
      chainChainManager2,
      new ChainManager()
    };
    ChainManager[] nullCM = null;

    test.startTest();
    chainChainManager.add(nullCM);
    chainChainManager.add(chains);
    test.stopTest();

    System.assertEquals(
      chainBatchLink,
      ChainManager.unchain(chainChainManager)[0],
      'First element of the chain should be ' + chainBatchLink
    );
  }

  @isTest
  static void testGetLastLink() {
    final AsyncLinkable chainFutureLink = new FutureLinkTest();
    final AsyncLinkable chainBatchLink = new BatchLinkTest();
    chainFutureLink.setNext(chainBatchLink);

    test.startTest();
    final AsyncLinkable lastLink = ChainManager.getLastLink(chainFutureLink);
    test.stopTest();

    System.assertEquals(
      chainBatchLink,
      lastLink,
      'Last element of the chain should be ' + chainBatchLink
    );
    System.assertEquals(
      null,
      ChainManager.getLastLink(null),
      'getLastLink should return null with null'
    );
  }

  @isTest
  static void testUnchainChainManager() {
    final ChainManager chainChainManager = new ChainManager(EXECUTOR);
    final AsyncLinkable chain = new FutureLinkTest();
    chain.setNext(new BatchLinkTest());
    chainChainManager.add(chain);

    test.startTest();
    final AsyncLinkable[] links = ChainManager.unchain(chainChainManager);
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
    final AsyncLinkable chain = new FutureLinkTest();
    chain.setNext(new BatchLinkTest());

    test.startTest();
    final AsyncLinkable[] links = ChainManager.unchain(chain);
    test.stopTest();

    System.assertEquals(
      chain,
      links[0],
      'First element of the chain should be ' + chain
    );
    System.assertEquals(2, links.size(), 'Size of links should be 2');
  }
}
