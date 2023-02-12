public inherited sharing abstract class QueueLink extends AsyncLinkable implements Queueable {
  protected QueueableContext qc;
  protected Integer delay;

  protected override abstract void job();

  // Respect the org-wide enqueue delay setting
  public QueueLink() {
    this(null);
  }

  // Use 0 to bypass the org-wide enqueue delay setting
  public QueueLink(final Integer delay) {
    super();
    this.delay = delay;
  }

  public void execute(QueueableContext qc) {
    this.qc = qc;
    this.prepareChaining();
    this.job();
    this.startChain();
  }

  public virtual override Id spawn() {
    return this.delay == null
      ? System.enqueueJob(this)
      : System.enqueueJob(this, this.delay);
  }
}
