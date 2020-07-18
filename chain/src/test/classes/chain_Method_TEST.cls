@isTest
public class chain_Method_TEST extends chain_Method {

  public chain_Method_TEST(){
    super();
  }

  public chain_Method_TEST(final boolean canBreak){
    this();
    this.canBreak = canBreak;
  }

  protected override void job() {
    System.Debug('chain_Method_TEST');
    if(this.canBreak == true) {
      throw new chain_MethodException();
    }
  }

  public class chain_MethodException extends Exception{}

  @isTest
  static void testFail() {
    chain_Chainable aChainable = new chain_Method_TEST(true);

    test.startTest();
    try {
      aChainable.spawnChain();
    } catch(chain_MethodException ex){}
    test.stopTest();
  }

  @isTest
  static void testSuccess() {
    chain_Chainable aChainable = new chain_Method_TEST();

    test.startTest();
    aChainable.spawnChain();
    test.stopTest();
  }
}