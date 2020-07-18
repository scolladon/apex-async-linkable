public inherited sharing abstract class chain_ScheduleBatch extends chain_Batch {
  protected String jobName;
  protected Integer minutesFromNow;

  protected override abstract void job();

  public chain_ScheduleBatch(final String jobName, final Integer minutesFromNow){
    super();
    this.init(jobName,minutesFromNow);
  }
  
  public chain_ScheduleBatch(final String jobName, final Integer minutesFromNow, final Integer scopeSize){
    super(scopeSize);
    this.init(jobName,minutesFromNow);
  }

  protected void init(final String jobName, final Integer minutesFromNow) {
    this.jobName = jobName;
    this.minutesFromNow = minutesFromNow > 0 ? minutesFromNow : 1;
  }

  public virtual override void spawn() {
    System.scheduleBatch(this, this.jobName, this.minutesFromNow, this.scopeSize);
  }
}