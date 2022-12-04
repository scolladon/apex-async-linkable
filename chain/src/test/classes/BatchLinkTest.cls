@isTest
public class BatchLinkTest extends BatchLink {
  private Boolean canBreak;

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

  public class BatchLinkException extends Exception {
  }

  @testSetup
  static void setup() {
    insert new Account(name = 'test');
  }

  @isTest
  static void testFail() {
    final BatchLinkTest anAsyncLinkable = new BatchLinkTest(true);

    test.startTest();
    try {
      anAsyncLinkable.execute(null, null);
      Assert.fail('should not be executed');
    } catch (BatchLinkException ex) {
      Assert.isNotNull(ex, 'Exception should be thrown');
    }
    test.stopTest();
  }

  @isTest
  static void testSuccess() {
    final AsyncLinkable anAsyncLinkable = new BatchLinkTest();

    test.startTest();
    final Id jobId = anAsyncLinkable.spawn();
    test.stopTest();
    Assert.isNotNull(jobId, 'Should be filled');
  }

  @isTest
  static void testSuccessScope() {
    final AsyncLinkable anAsyncLinkable = new BatchLinkTest(-1);

    test.startTest();
    final Id jobId = anAsyncLinkable.spawn();
    test.stopTest();
    Assert.isNotNull(jobId, 'Should be filled');
  }
}
