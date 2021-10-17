public inherited sharing abstract class QueueLink extends AsyncLinkable implements Queueable {
  protected QueueableContext qc;

  protected override abstract void job();

  public QueueLink() {
    super();
  }

  public void execute(QueueableContext qc) {
    this.qc = qc;
    this.prepareChaining();
    this.job();
    this.startChain();
  }

  public virtual override Id spawn() {
    return System.enqueueJob(this);
  }
}
