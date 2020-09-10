@isTest
public class chain_Future_TEST extends chain_Future {
  public chain_Future_TEST() {
    super();
  }

  public chain_Future_TEST(final boolean canBreak) {
    this();
    this.canBreak = canBreak;
  }

  protected override void job() {
    if (this.canBreak == true) {
      throw new chain_FutureException();
    }
  }

  public class chain_FutureException extends Exception {
  }

  @isTest
  static void testFail() {
    final chain_Chainable aChainable = new chain_Future_TEST(true);

    test.startTest();
    try {
      aChainable.job();
      System.Assert(false, 'should not be executed');
    } catch (chain_FutureException ex) {
      System.AssertNotEquals(null, ex, 'Exception should be thrown');
    }
    test.stopTest();
  }

  @isTest
  static void testSuccess() {
    final chain_Chainable aChainable = new chain_Future_TEST();

    test.startTest();
    aChainable.spawn();
    System.AssertNotEquals(0, Limits.getFutureCalls(), 'Should not be 0');
    test.stopTest();
  }
}
