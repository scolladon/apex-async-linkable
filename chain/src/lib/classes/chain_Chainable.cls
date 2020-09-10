public inherited sharing abstract class chain_Chainable {
  protected chain_Chainable nextLink;
  protected boolean canBreak;
  protected String internalExecutor;

  public abstract Id spawn();
  protected abstract void job();

  public chain_Chainable() {
    this.canBreak = false;
    this.internalExecutor = EncodingUtil.convertToHex(
        Crypto.generateAesKey(128)
      )
      .substring(0, 32);
  }

  protected virtual void prepareChaining() {
    chain_Manager.instance.registerExecutor(this.internalExecutor);
    chain_Manager.instance.add(this.nextLink);
  }

  protected void spawnChain() {
    chain_Manager.instance.spawnChain(this.internalExecutor);
  }

  public virtual void setNext(final chain_Chainable link) {
    this.nextLink = link;
  }

  public virtual chain_Chainable getNext() {
    return this.nextLink;
  }

  public virtual Boolean hasNext() {
    return this.getNext() != null;
  }
}
