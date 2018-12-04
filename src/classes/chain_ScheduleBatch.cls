public inherited sharing abstract class chain_ScheduleBatch extends chain_Batch {
  static private final Integer MAX_SCOPE_SIZE = 2000;
  protected String jobName;
  protected Integer minutesFromNow;
  protected Integer scopeSize;
  
  protected chain_ScheduleBatch(){
    super();
  }
  
  public chain_ScheduleBatch(final String jobName, final Integer minutesFromNow, final Integer scopeSize){
    this();
    this.jobName = jobName;
    this.minutesFromNow = minutesFromNow;
    this.scopeSize = scopeSize;
  }

  protected override abstract void job();

  public virtual override void executeChain() {
    if(this.scopeSize == null || this.scopeSize < 1 || this.scopeSize > MAX_SCOPE_SIZE) {
        this.scopeSize = MAX_SCOPE_SIZE;
    }
    System.scheduleBatch(this, this.jobName, this.minutesFromNow, this.scopeSize);
  }
}