public inherited sharing abstract class AsyncLinkable {
  protected AsyncLinkable nextLink;
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

  public virtual void accept(Visitor aVisitor) {
    aVisitor.visit(this);
  }

  public interface Visitor {
    void visit(final AsyncLinkable aLink);
  }

  public inherited sharing class AsyncLinkIterable implements Iterable<AsyncLinkable> {
    public AsyncLinkable link { get; set; }
    public AsyncLinkIterable(final AsyncLinkable link) {
      this.link = link;
    }

    public Iterator<AsyncLinkable> iterator() {
      return new AsyncLinkIterator(this);
    }
  }

  public inherited sharing class AsyncLinkIterator implements Iterator<AsyncLinkable> {
    private AsyncLinkIterable linkIterable;

    private AsyncLinkIterator(AsyncLinkIterable linkIterable) {
      this.linkIterable = linkIterable;
    }

    public Boolean hasNext() {
      return this.linkIterable.link?.nextLink != null;
    }

    public AsyncLinkable next() {
      this.linkIterable.link = this.linkIterable?.link?.nextLink;
      return this.linkIterable?.link;
    }
  }
}
