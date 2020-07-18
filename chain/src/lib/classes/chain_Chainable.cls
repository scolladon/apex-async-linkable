public inherited sharing abstract class chain_Chainable {
  protected chain_Chainable nextLink;
  protected boolean canBreak;
  protected String internalExecutor;

  public abstract void spawn();
  protected abstract void job();
  
  public chain_Chainable() {
    this.canBreak = false;
    this.internalExecutor = EncodingUtil.convertToHex(Crypto.generateAesKey(128)).substring(0, 32);
  }

  protected virtual void prepareChaining() {
    chain_Manager.CM.registerExecutor(this.internalExecutor);
    chain_Manager.CM.add(this.nextLink);
  }

  protected void spawnChain() {
    chain_Manager.CM.spawnChain(this.internalExecutor);
  }

  public virtual void setNext(final chain_Chainable link) {
    this.nextLink = link;
  }
}

