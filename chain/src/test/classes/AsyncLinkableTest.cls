@isTest
private class AsyncLinkableTest {
  @testSetup
  static void setup() {
    insert new Account(name = 'test');
  }

  @isTest
  static void testAll() {
    AsyncLinkable aBatchLink1 = new BatchLinkTest();
    AsyncLinkable aFutureLink1 = new FutureLinkTest();
    AsyncLinkable aScheduleLink1 = new ScheduleLinkTest('test', '0 0 * * * ?');
    AsyncLinkable aFutureLink2 = new FutureLinkTest();
    AsyncLinkable aFutureLink3 = new FutureLinkTest();
    AsyncLinkable aScheduleBatchLink1 = new ScheduleBatchLinkTest('test', 1);
    AsyncLinkable aFutureLink4 = new FutureLinkTest();
    AsyncLinkable aQueueLink1 = new QueueLinkTest();

    aBatchLink1.setNext(aFutureLink1);
    aFutureLink1.setNext(aScheduleLink1);
    aScheduleLink1.setNext(aFutureLink2);
    aFutureLink2.setNext(aFutureLink3);
    aFutureLink3.setNext(aScheduleBatchLink1);
    aScheduleBatchLink1.setNext(aFutureLink4);
    aFutureLink4.setNext(aQueueLink1);

    test.startTest();
    final Id jobId = aBatchLink1.spawn();
    test.stopTest();
    System.AssertNotEquals(null, jobId, 'Should be filled');
  }

  @isTest
  static void testQueueLink() {
    final AsyncLinkable aAsyncLinkable = new QueueLinkTest();

    test.startTest();
    final Id jobId = aAsyncLinkable.spawn();
    test.stopTest();
    System.AssertNotEquals(null, jobId, 'Should be filled');
  }

  @isTest
  static void testScheduleBatchLink() {
    final AsyncLinkable aAsyncLinkable = new ScheduleBatchLinkTest('test', 1);

    test.startTest();
    final Id jobId = aAsyncLinkable.spawn();
    test.stopTest();
    System.AssertNotEquals(null, jobId, 'Should be filled');
  }
}
