public inherited sharing class AsyncLinkIterable implements Iterable<AsyncLinkable> {
  public AsyncLinkable link { get; private set; }
  public AsyncLinkIterable(final AsyncLinkable link) {
    this.link = link;
  }

  public Iterator<AsyncLinkable> iterator() {
    return new AsyncLinkIterator(this);
  }

  public inherited sharing class AsyncLinkIterator implements Iterator<AsyncLinkable> {
    private AsyncLinkIterable linkIterable;
    private Boolean hasStarted;

    private AsyncLinkIterator(AsyncLinkIterable linkIterable) {
      this.linkIterable = linkIterable;
      this.hasStarted = false;
    }

    public Boolean hasNext() {
      return !hasStarted
        ? this.linkIterable?.link != null
        : this.linkIterable?.link?.nextLink != null;
    }

    public AsyncLinkable next() {
      if (!this.hasStarted) {
        this.hasStarted = true;
        return this.linkIterable.link;
      }
      this.linkIterable.link = this.linkIterable?.link?.nextLink;
      return this.linkIterable?.link;
    }
  }
}
