@isTest
public class BatchLinkTest extends BatchLink {
  public override Database.QueryLocator start(Database.BatchableContext bc) {
    return Database.getQueryLocator('select id from account limit 1');
  }

  public BatchLinkTest() {
    super();
  }

  public BatchLinkTest(final Integer scopeSize) {
    super(scopeSize);
  }

  public BatchLinkTest(final boolean canBreak) {
    this();
    this.canBreak = canBreak;
  }

  protected override void job() {
    if (this.canBreak == true) {
      throw new BatchLinkException();
    }
  }

  protected override void finish() {
  }

  public class BatchLinkException extends Exception {
  }

  @testSetup
  static void setup() {
    insert new Account(name = 'test');
  }

  @isTest
  static void testFail() {
    final BatchLinkTest aAsyncLinkable = new BatchLinkTest(true);

    test.startTest();
    try {
      aAsyncLinkable.execute(null, null);
      System.Assert(false, 'should not be executed');
    } catch (BatchLinkException ex) {
      System.AssertNotEquals(null, ex, 'Exception should be thrown');
    }
    test.stopTest();
  }

  @isTest
  static void testSuccess() {
    final AsyncLinkable aAsyncLinkable = new BatchLinkTest();

    test.startTest();
    final Id jobId = aAsyncLinkable.spawn();
    test.stopTest();
    System.AssertNotEquals(null, jobId, 'Should be filled');
  }

  @isTest
  static void testSuccessScope() {
    final AsyncLinkable aAsyncLinkable = new BatchLinkTest(-1);

    test.startTest();
    final Id jobId = aAsyncLinkable.spawn();
    test.stopTest();
    System.AssertNotEquals(null, jobId, 'Should be filled');
  }
}
