public inherited sharing abstract class chain_Schedule extends chain_Chainable implements Schedulable {
  protected String cronExp;
  protected String jobName;
  protected SchedulableContext sc;

  protected override abstract void job();

  public chain_Schedule() {
    super();
  }

  public chain_Schedule(final String jobName, final String cronExp) {
    this();
    this.jobName = jobName;
    this.cronExp = cronExp;
  }

  public void execute(SchedulableContext sc) {
    this.sc = sc;
    this.prepareChaining();
    this.job();
    this.spawnChain();
  }

  public virtual override Id spawn() {
    return System.schedule(this.jobName, this.cronExp, this);
  }
}
