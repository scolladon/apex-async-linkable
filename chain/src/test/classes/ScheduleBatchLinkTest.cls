@isTest
public class ScheduleBatchLinkTest extends ScheduleBatchLink {
  public ScheduleBatchLinkTest(
    final String jobName,
    final Integer minutesFromNow
  ) {
    super(jobName, minutesFromNow);
  }

  public ScheduleBatchLinkTest(
    final String jobName,
    final Integer minutesFromNow,
    final Integer scopeSize,
    final boolean canBreak
  ) {
    super(jobName, minutesFromNow, scopeSize);
    this.canBreak = canBreak;
  }

  public override Database.QueryLocator start(Database.BatchableContext bc) {
    return Database.getQueryLocator('select id from account limit 1');
  }

  protected override void job() {
    if (this.canBreak == true) {
      throw new ScheduleBatchLinkException();
    }
  }

  protected override void finish() {
  }

  public class ScheduleBatchLinkException extends Exception {
  }

  @testSetup
  static void setup() {
    insert new Account(name = 'test');
  }

  @isTest
  static void testFail() {
    final ScheduleBatchLinkTest anAsyncLinkable = new ScheduleBatchLinkTest(
      'test',
      1,
      1,
      true
    );

    test.startTest();
    try {
      anAsyncLinkable.execute(null, null);
      Assert.fail('should not be executed');
    } catch (ScheduleBatchLinkException ex) {
      Assert.isNotNull(ex, 'Exception should be thrown');
    }
    test.stopTest();
  }

  @isTest
  static void testSuccess() {
    final AsyncLinkable anAsyncLinkable = new ScheduleBatchLinkTest('test', 1);

    test.startTest();
    final Id jobId = anAsyncLinkable.spawn();
    test.stopTest();
    Assert.isNotNull(jobId, 'Should be filled');
  }
}
