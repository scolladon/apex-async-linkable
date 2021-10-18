@isTest
public class QueueLinkTest extends QueueLink {
  public QueueLinkTest() {
    super();
  }

  public QueueLinkTest(final boolean canBreak) {
    this();
    this.canBreak = canBreak;
  }

  protected override void job() {
    if (this.canBreak == true) {
      throw new QueueLinkException();
    }
  }

  public class QueueLinkException extends Exception {
  }

  @isTest
  static void testFail() {
    final QueueLinkTest anAsyncLinkable = new QueueLinkTest(true);

    test.startTest();
    try {
      anAsyncLinkable.execute(null);
      System.Assert(false, 'should not be executed');
    } catch (QueueLinkException ex) {
      System.AssertNotEquals(null, ex, 'Exception should be thrown');
    }
    test.stopTest();
  }

  @isTest
  static void testSuccess() {
    final AsyncLinkable anAsyncLinkable = new QueueLinkTest();

    test.startTest();
    final Id jobId = anAsyncLinkable.spawn();
    test.stopTest();
    System.AssertNotEquals(null, jobId, 'Should be filled');
  }
}
