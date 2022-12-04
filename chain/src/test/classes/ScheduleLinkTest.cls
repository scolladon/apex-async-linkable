@isTest
public class ScheduleLinkTest extends ScheduleLink {
  private Boolean canBreak;
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
    final ScheduleLinkTest anAsyncLinkable = new ScheduleLinkTest(
      'test',
      '0 0 * * * ?',
      true
    );

    test.startTest();
    try {
      anAsyncLinkable.execute(null);
      Assert.fail('should not be executed');
    } catch (ScheduleLinkException ex) {
      Assert.isNotNull(ex, 'Exception should be thrown');
    }
    test.stopTest();
  }

  @isTest
  static void testSuccess() {
    final AsyncLinkable anAsyncLinkable = new ScheduleLinkTest(
      'test',
      '0 0 * * * ?'
    );

    test.startTest();
    final Id jobId = anAsyncLinkable.spawn();
    test.stopTest();
    Assert.isNotNull(jobId, 'Should be filled');
  }
}
