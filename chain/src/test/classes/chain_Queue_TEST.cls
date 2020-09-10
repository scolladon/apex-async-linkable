@isTest
public class chain_Queue_TEST extends chain_Queue {
  public chain_Queue_TEST() {
    super();
  }

  public chain_Queue_TEST(final boolean canBreak) {
    this();
    this.canBreak = canBreak;
  }

  protected override void job() {
    if (this.canBreak == true) {
      throw new chain_QueueException();
    }
  }

  public class chain_QueueException extends Exception {
  }

  @isTest
  static void testFail() {
    final chain_Queue_TEST aChainable = new chain_Queue_TEST(true);

    test.startTest();
    try {
      aChainable.execute(null);
      System.Assert(false, 'should not be executed');
    } catch (chain_QueueException ex) {
      System.AssertNotEquals(null, ex, 'Exception should be thrown');
    }
    test.stopTest();
  }

  @isTest
  static void testSuccess() {
    final chain_Chainable aChainable = new chain_Queue_TEST();

    test.startTest();
    final Id jobId = aChainable.spawn();
    test.stopTest();
    System.AssertNotEquals(null, jobId, 'Should be filled');
  }
}
