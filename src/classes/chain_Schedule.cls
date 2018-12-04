public inherited sharing abstract class chain_Schedule extends chain_Chainable implements Schedulable {
  protected String cronExp;
  protected String jobName;
  protected SchedulableContext sc;

  public chain_Schedule(){
    super();
  }

  public chain_Schedule(final String jobName, final String cronExp){
    this();
    this.jobName = jobName;
    this.cronExp = cronExp;
  }

  protected override abstract void job();

  public void execute(SchedulableContext sc){
    this.sc = sc;
    try {
      this.job();
    } catch(Exception ex) {
      if(this.canBreak == true) {
        throw ex;
      }
    }
    this.chain();
  }

  public virtual override void executeChain() {
    System.schedule(this.jobName, this.cronExp, this);
  }
}