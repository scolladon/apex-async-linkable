public inherited sharing abstract class chain_Batch extends chain_Chainable implements Database.Batchable<sObject> {
  static public final Integer MAX_SCOPE_SIZE = 2000;
  protected Database.BatchableContext bc;
  protected List<sObject> scope;
  protected Integer scopeSize;

  protected override abstract void job();

  public chain_Batch() {
    super();
    this.scopeSize = chain_Batch.MAX_SCOPE_SIZE;
  }

  public chain_Batch(final Integer scopeSize) {
    super();
    this.scopeSize = (scopeSize == null ||
      scopeSize < 1 ||
      scopeSize > chain_Batch.MAX_SCOPE_SIZE)
      ? chain_Batch.MAX_SCOPE_SIZE
      : scopeSize;
  }

  public abstract Database.QueryLocator start(Database.BatchableContext bc);

  public virtual void execute(
    Database.BatchableContext bd,
    List<sObject> scope
  ) {
    this.bc = bc;
    this.scope = scope;
    this.job();
  }

  protected abstract void finish();

  public virtual void finish(Database.BatchableContext bc) {
    this.bc = bc;
    this.prepareChaining();
    this.finish();
    this.spawnChain();
  }

  public virtual override Id spawn() {
    return Database.executeBatch(this, this.scopeSize);
  }

  public override void setNext(final chain_Chainable link) {
    if (!(link instanceof chain_Future)) {
      super.setNext(link);
    }
  }
}
