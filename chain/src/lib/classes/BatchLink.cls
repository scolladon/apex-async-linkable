public inherited sharing abstract class BatchLink extends AsyncLinkable implements Database.Batchable<sObject> {
  static public final Integer MAX_SCOPE_SIZE = 2000;
  protected Database.BatchableContext bc;
  protected List<sObject> scope;
  protected Integer scopeSize;

  protected override abstract void job();

  public BatchLink() {
    super();
    this.scopeSize = BatchLink.MAX_SCOPE_SIZE;
  }

  public BatchLink(final Integer scopeSize) {
    super();
    this.scopeSize = (scopeSize == null ||
      scopeSize < 1 ||
      scopeSize > BatchLink.MAX_SCOPE_SIZE)
      ? BatchLink.MAX_SCOPE_SIZE
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

  protected virtual void finish() {
  }

  public virtual void finish(Database.BatchableContext bc) {
    this.bc = bc;
    this.prepareChaining();
    this.finish();
    this.startChain();
  }

  public virtual override Id spawn() {
    return Database.executeBatch(this, this.scopeSize);
  }

  public override void setNext(final AsyncLinkable link) {
    if (!(link instanceof FutureLink)) {
      super.setNext(link);
    }
  }
}
