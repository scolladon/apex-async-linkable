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
    this.job();
    this.chain();
  }

  public virtual override void executeChain() {
    // TODO Add priority notion and add the date in the table. (handle the rest of the chain)
    // TODO the scheduler need to see the date and schedule it close from the date
    System.schedule(this.jobName, this.cronExp, this);
  }
}