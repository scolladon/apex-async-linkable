public inherited sharing abstract class chain_Batch extends chain_Chainable implements Database.Batchable<sObject> {
  static public final Integer MAX_SCOPE_SIZE = 2000;
  protected Database.BatchableContext bc;
  protected List<sObject> scope;
  protected Integer scopeSize;

  public chain_Batch(){
    super();
    this.scopeSize = chain_Batch.MAX_SCOPE_SIZE;
  }

  public chain_Batch(final Integer scopeSize){
    this();    
    this.scopeSize = scopeSize;
    if(this.scopeSize == null || this.scopeSize < 1 || this.scopeSize > chain_Batch.MAX_SCOPE_SIZE) {
        this.scopeSize = chain_Batch.MAX_SCOPE_SIZE;
    }
  }

  protected override abstract void job();

  public abstract Database.QueryLocator start(Database.BatchableContext bc);

  public virtual void execute(Database.BatchableContext bd, List<sObject> scope){
    this.bc = bc;
    this.scope = scope;
    this.job();
  }

  public virtual void finish(Database.BatchableContext bc){
    this.chain();
  }

  public virtual override void executeChain() {
    Database.executeBatch(this);
  }

  public override chain_Chainable add(final chain_Chainable aChain) {
    if(!(aChain instanceof chain_Future)) {
      return super.add(aChain);
    }
    return this;
  }
}