@isTest
public class ScheduleLinkTest extends ScheduleLink {
  public ScheduleLinkTest(
    final String jobName,
    final String cronExp,
    final boolean canBreak
  ) {
    this(jobName, cronExp);
    this.canBreak = canBreak;
  }

  public ScheduleLinkTest(final String jobName, final String cronExp) {
    super(jobName, cronExp);
  }

  protected override void job() {
    if (this.canBreak == true) {
      throw new ScheduleLinkException();
    }
  }

  public class ScheduleLinkException extends Exception {
  }

  @isTest
  static void testFail() {
    final ScheduleLinkTest aAsyncLinkable = new ScheduleLinkTest(
      'test',
      '0 0 * * * ?',
      true
    );

    test.startTest();
    try {
      aAsyncLinkable.execute(null);
      System.Assert(false, 'should not be executed');
    } catch (ScheduleLinkException ex) {
      System.AssertNotEquals(null, ex, 'Exception should be thrown');
    }
    test.stopTest();
  }

  @isTest
  static void testSuccess() {
    final AsyncLinkable aAsyncLinkable = new ScheduleLinkTest(
      'test',
      '0 0 * * * ?'
    );

    test.startTest();
    final Id jobId = aAsyncLinkable.spawn();
    test.stopTest();
    System.AssertNotEquals(null, jobId, 'Should be filled');
  }
}
