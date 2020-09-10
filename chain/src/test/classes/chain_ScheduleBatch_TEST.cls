@isTest
public class chain_ScheduleBatch_TEST extends chain_ScheduleBatch {
  public chain_ScheduleBatch_TEST(
    final String jobName,
    final Integer minutesFromNow
  ) {
    super(jobName, minutesFromNow);
  }

  public chain_ScheduleBatch_TEST(
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
      throw new chain_ScheduleBatchException();
    }
  }

  protected override void finish() {
  }

  public class chain_ScheduleBatchException extends Exception {
  }

  @testSetup
  static void setup() {
    insert new Account(name = 'test');
  }

  @isTest
  static void testFail() {
    chain_ScheduleBatch_TEST aChainable = new chain_ScheduleBatch_TEST(
      'test',
      1,
      1,
      true
    );

    test.startTest();
    try {
      aChainable.execute(null, null);
    } catch (chain_ScheduleBatchException ex) {
    }
    test.stopTest();
  }

  @isTest
  static void testSuccess() {
    chain_Chainable aChainable = new chain_ScheduleBatch_TEST('test', 1);

    test.startTest();
    aChainable.spawn();
    test.stopTest();
  }
}
