public inherited sharing abstract class chain_Queue extends chain_Chainable implements Queueable {
  
  protected QueueableContext qc;

  protected override abstract void job();
  
  public chain_Queue(){
    super();
  }

  public void execute(QueueableContext qc) {
    this.qc = qc;
    this.prepareChaining();
    this.job();
    this.spawnChain();
  }

  public virtual override void spawn() {
    System.enqueueJob(this);
  }
}