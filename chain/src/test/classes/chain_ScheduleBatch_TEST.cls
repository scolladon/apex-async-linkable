@isTest
public class chain_ScheduleBatch_TEST extends chain_ScheduleBatch{

  public chain_ScheduleBatch_TEST(final String jobName, final Integer minutesFromNow, final Integer scopeSize){
    super(jobName,minutesFromNow,scopeSize);
  }

  public chain_ScheduleBatch_TEST(final String jobName, final Integer minutesFromNow, final Integer scopeSize, final boolean canBreak){
    this(jobName,minutesFromNow,scopeSize);
    this.canBreak = canBreak;
  }

  public override Database.QueryLocator start(Database.BatchableContext bc) {
    return Database.getQueryLocator('select id from account limit 1');
  }

  public chain_ScheduleBatch_TEST(){
    super();
  }

  public chain_ScheduleBatch_TEST(final boolean canBreak){
    this();
    this.canBreak = canBreak;
  }

  protected override void job() {
    System.Debug('chain_ScheduleBatch_TEST');
    if(this.canBreak == true) {
      throw new chain_ScheduleBatchException();
    }
  }

  public class chain_ScheduleBatchException extends Exception{}

  @testSetup
  static void setup(){
    insert new Account(name='test');
  }

  @isTest
  static void testFail() {
    chain_ScheduleBatch_TEST aChainable = new chain_ScheduleBatch_TEST();
    aChainable = new chain_ScheduleBatch_TEST('test',1,1,true);

    test.startTest();
    try {
      aChainable.execute(null,null);
    } catch(chain_ScheduleBatchException ex){}
    test.stopTest();
  }

  @isTest
  static void testSuccess() {
    chain_Chainable aChainable = new chain_ScheduleBatch_TEST('test',1,1);

    test.startTest();
    aChainable.spawnChain();
    test.stopTest();
  }
}