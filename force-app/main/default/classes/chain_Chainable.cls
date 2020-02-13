public inherited sharing abstract class chain_Chainable {
  protected chain_Chainable nextJob;
  protected boolean canBreak;
  protected abstract void job();

  

  // Deal with add enqueue readding reenqueue

  public chain_Chainable() {
    this.canBreak = false;
  }

  public abstract void executeChain();
  
  // TODO execution strategy (exception handling, retry handling)
  //protected chain_ExceptionStrategy exceptionStrategy;
  /*public abstract void executeChain(chain_ExceptionStrategy exceptionStrategy) {
    this.setExceptionStrategy(exceptionStrategy);
  }

  public void setExceptionStrategy(chain_ExceptionStrategy exceptionStrategy) {
    this.chain_ExceptionStrategy = exceptionStrategy;
  }

  public chain_ExceptionStrategy setExceptionStrategy() {
    return this.chain_ExceptionStrategy;
  }*/

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
      // TODO handle the exception due to limit of the treatment spawn when error. Persistence
      // TODO Scheduled job every minute to execute all the elements in the list
      // TODO test limit in each executeChain
      this.nextJob.executeChain();
      this.nextJob = null;
    }
  }
}