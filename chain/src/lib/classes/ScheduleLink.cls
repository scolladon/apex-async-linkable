public inherited sharing abstract class ScheduleLink extends AsyncLinkable implements Schedulable {
  protected String cronExp;
  protected String jobName;
  protected SchedulableContext sc;

  protected override abstract void job();

  public ScheduleLink() {
    super();
  }

  public ScheduleLink(final String jobName, final String cronExp) {
    this();
    this.jobName = jobName;
    this.cronExp = cronExp;
  }

  public void execute(SchedulableContext sc) {
    this.sc = sc;
    this.prepareChaining();
    this.job();
    this.startChain();
  }

  public virtual override Id spawn() {
    return System.schedule(this.jobName, this.cronExp, this);
  }
}
