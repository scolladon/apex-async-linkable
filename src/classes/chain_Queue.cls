public inherited sharing abstract class chain_Queue extends chain_Chainable implements Queueable {
  protected override abstract void job();
  protected QueueableContext qc;

  public chain_Queue(){
    super();
  }

  public void execute(QueueableContext qc) {
    this.qc = qc;
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
    System.enqueueJob(this);
  }
}