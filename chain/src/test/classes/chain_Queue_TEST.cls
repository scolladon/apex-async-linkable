@isTest
public class chain_Queue_TEST extends chain_Queue {

  public chain_Queue_TEST(){
    super();
  }

  public chain_Queue_TEST(final boolean canBreak){
    this();
    this.canBreak = canBreak;
  }

  protected override void job() {
    System.Debug('chain_Queue_TEST');
    if(this.canBreak == true) {
      throw new chain_QueueException();
    }
  }

  public class chain_QueueException extends Exception{}

  @isTest
  static void testFail() {
    chain_Queue_TEST aChainable = new chain_Queue_TEST(true);

    test.startTest();
    try {
      aChainable.execute(null);
    } catch(chain_QueueException ex){}
    test.stopTest();
  }

  @isTest
  static void testSuccess() {
    chain_Chainable aChainable = new chain_Queue_TEST();

    test.startTest();
    aChainable.spawnChain();
    test.stopTest();
  }
}