@isTest
public class chain_Batch_TEST extends chain_Batch {
  public override Database.QueryLocator start(Database.BatchableContext bc) {
    return Database.getQueryLocator('select id from account limit 1');
  }

  public chain_Batch_TEST() {
    super();
  }

  public chain_Batch_TEST(final Integer scopeSize) {
    super(scopeSize);
  }

  public chain_Batch_TEST(final boolean canBreak) {
    this();
    this.canBreak = canBreak;
  }

  protected override void job() {
    if (this.canBreak == true) {
      throw new chain_BatchException();
    }
  }

  protected override void finish() {
  }

  public class chain_BatchException extends Exception {
  }

  @testSetup
  static void setup() {
    insert new Account(name = 'test');
  }

  @isTest
  static void testFail() {
    final chain_Batch_TEST aChainable = new chain_Batch_TEST(true);

    test.startTest();
    try {
      aChainable.execute(null, null);
      System.Assert(false, 'should not be executed');
    } catch (chain_BatchException ex) {
      System.AssertNotEquals(null, ex, 'Exception should be thrown');
    }
    test.stopTest();
  }

  @isTest
  static void testSuccess() {
    final chain_Chainable aChainable = new chain_Batch_TEST();

    test.startTest();
    final Id jobId = aChainable.spawn();
    test.stopTest();
    System.AssertNotEquals(null, jobId, 'Should be filled');
  }

  @isTest
  static void testSuccessScope() {
    final chain_Chainable aChainable = new chain_Batch_TEST(-1);

    test.startTest();
    final Id jobId = aChainable.spawn();
    test.stopTest();
    System.AssertNotEquals(null, jobId, 'Should be filled');
  }
}
