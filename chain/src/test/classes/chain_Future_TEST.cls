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
    chain_Chainable aChainable = new chain_Future_TEST(true);

    test.startTest();
    try {
      aChainable.job();
    } catch (chain_FutureException ex) {
    }
    test.stopTest();
  }

  @isTest
  static void testSuccess() {
    chain_Chainable aChainable = new chain_Future_TEST();

    test.startTest();
    aChainable.spawn();
    test.stopTest();
  }
}
