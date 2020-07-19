@isTest
public class chain_Schedule_TEST extends chain_Schedule {

  public chain_Schedule_TEST(final String jobName, final String cronExp, final boolean canBreak){
    this(jobName, cronExp);
    this.canBreak = canBreak;
  }

  public chain_Schedule_TEST(final String jobName, final String cronExp){
    super(jobName,cronExp);
  }

  protected override void job() {
    if(this.canBreak == true) {
      throw new chain_ScheduleException();
    }
  } 

  public class chain_ScheduleException extends Exception{}

  @isTest
  static void testFail() {
    chain_Schedule_TEST aChainable = new chain_Schedule_TEST('test','0 0 * * * ?',true);

    test.startTest();
    try {
      aChainable.execute(null);
    } catch(chain_ScheduleException ex){}
    test.stopTest();
  }

  @isTest
  static void testSuccess() {
    chain_Chainable aChainable = new chain_Schedule_TEST('test','0 0 * * * ?');

    test.startTest();
    aChainable.spawn();
    test.stopTest();
  }
}