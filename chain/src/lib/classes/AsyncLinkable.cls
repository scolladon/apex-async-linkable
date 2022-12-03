public inherited sharing abstract class AsyncLinkable {
  public AsyncLinkable nextLink { get; private set; }
  protected boolean canBreak;
  protected String internalExecutor;

  public abstract Id spawn();
  protected abstract void job();

  public AsyncLinkable() {
    this.canBreak = false;
    this.internalExecutor = EncodingUtil.convertToHex(
        Crypto.generateAesKey(128)
      )
      .substring(0, 32);
  }

  protected virtual void prepareChaining() {
    ChainManager.instance.registerExecutor(this.internalExecutor);
    ChainManager.instance.add(this.nextLink);
  }

  protected void startChain() {
    ChainManager.instance.startChain(this.internalExecutor);
  }

  public virtual void setNext(final AsyncLinkable link) {
    this.nextLink = link;
  }

  public virtual void accept(LinkVisitor aVisitor) {
    aVisitor.visit(this);
  }

  public interface LinkVisitor {
    void visit(final AsyncLinkable aLink);
  }
}
