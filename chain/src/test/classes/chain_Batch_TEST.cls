@isTest
public class chain_Batch_TEST extends chain_Batch {
  public override Database.QueryLocator start(Database.BatchableContext bc) {
    return Database.getQueryLocator('select id from account limit 1');
  }

  public chain_Batch_TEST(){
    super();
  }

  public chain_Batch_TEST(final boolean canBreak){
    this();
    this.canBreak = canBreak;
  }

  protected override void job() {
    System.Debug('chain_Batch_TEST');
    if(this.canBreak == true) {
      throw new chain_BatchException();
    }
  }

  public class chain_BatchException extends Exception{}

  @testSetup
  static void setup(){
    insert new Account(name='test');
  }

  @isTest
  static void testFail() {
    chain_Batch_TEST aChainable = new chain_Batch_TEST(true);

    test.startTest();
    try {
      aChainable.execute(null,null);
    } catch(chain_BatchException ex){}
    test.stopTest();
  }

  @isTest
  static void testSuccess() {
    chain_Chainable aChainable = new chain_Batch_TEST();

    test.startTest();
    aChainable.spawnChain();
    test.stopTest();
  }
}