public inherited sharing abstract class chain_ScheduleBatch extends chain_Batch {
  protected String jobName;
  protected Integer minutesFromNow;
  
  protected chain_ScheduleBatch(){
    super();
  }
  
  public chain_ScheduleBatch(final String jobName, final Integer minutesFromNow, final Integer scopeSize){
    super(scopeSize);
    this.jobName = jobName;
    this.minutesFromNow = minutesFromNow > 0 ? minutesFromNow : 1;
  }

  protected override abstract void job();

  public virtual override void executeChain() {
    System.scheduleBatch(this, this.jobName, this.minutesFromNow, this.scopeSize);
  }
}