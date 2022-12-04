public inherited sharing class AsyncLinkIterator implements Iterator<AsyncLinkable> {
  public AsyncLinkable link { get; private set; }
  private Boolean hasStarted;

  public AsyncLinkIterator(final AsyncLinkable link) {
    this.link = link;
    this.hasStarted = false;
  }

  public Boolean hasNext() {
    return !hasStarted ? this.link != null : this.link?.nextLink != null;
  }

  public AsyncLinkable next() {
    if (!this.hasStarted) {
      this.hasStarted = true;
      return this.link;
    }
    this.link = this.link?.nextLink;
    return this.link;
  }
}
