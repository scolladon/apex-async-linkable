public inherited sharing abstract class chain_Chainable {
  protected chain_Chainable nextJob;
  protected boolean canBreak;
  protected abstract void job();

  // Deal with add enqueue readding reenqueue

  public chain_Chainable() {
    this.canBreak = false;
  }

  public abstract void executeChain();

  public virtual chain_Chainable add(final chain_Chainable aChain) {
    this.nextJob = aChain;
    chain_Chainable tempChain = aChain;
    while(tempChain != null && tempChain.nextJob != null) {
      tempChain = tempChain.nextJob;
    }
    return tempChain;
  }

  protected void chain() {
    if(this.nextJob != null) {
      this.nextJob.executeChain();
      this.nextJob = null;
    }
  }
}