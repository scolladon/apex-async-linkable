public inherited sharing class chain_Manager {
  protected chain_Chainable first;
  protected chain_Chainable start;
  protected chain_Chainable last;
  protected chain_Chainable latest;
  protected String executor;

  public chain_Manager(){}

  public chain_Manager(final String anExecutor){
    this.registerExecutor(anExecutor);
  }

  /*******************************************************************************************************
  * @description Add a chain_Manager to the chain
  * @param aChainManager to add in the chain
  */
  public chain_Chainable add(final chain_Manager aChainManager) {
    if(this === aChainManager) {
      return this.last;  
    }
    if(aChainManager.first != null) {
      this.add(aChainManager.first);
    }
    this.add(aChainManager.start);
    if(aChainManager.latest != null) {
      this.add(aChainManager.latest);
    }
    return this.last;
  }

  /*******************************************************************************************************
  * @description Add a chain_Chainable to the chain
  * @param aChainable to add in the chain
  */
  public chain_Chainable add(final chain_Chainable aChainable) {
    if(this.start == null) {
      this.start = aChainable;
      this.last = this.start;
    } else {
      this.last = this.last.add(aChainable);
    }
    return this.last;
  }

  /*******************************************************************************************************
  * @description Add a chain_Chainable at the start of the chain
  * @param aChainable to add in the chain
  */
  public chain_Chainable first(final chain_Chainable aChainable) {
    this.first = aChainable;
    return this.last;
  }

  /*******************************************************************************************************
  * @description Add a chain_Chainable that will be executed after all other chain_Chainable no matter when it is added
  * @param aChainable to add in the chain
  */
  public chain_Chainable last(final chain_Chainable aChainable) {
    this.latest = aChainable;
    return this.last;
  }

  /*******************************************************************************************************
  * @description Register an executor that will be the only one to be allowed to run the chain
  * @param anExecutor to register
  */
  public void registerExecutor(final String anExecutor) {
    if(String.isBlank(this.executor) && String.isNotBlank(anExecutor)){
      this.executor = anExecutor;    
    }
  }

  /*******************************************************************************************************
  * @description Execute the first job of the chain to trigger all the chain if no executor is registered
  */
  public void executeChain() {
    if(String.isBlank(this.executor)) {
      this.doExecuteChain();
    }
  }

  /*******************************************************************************************************
  * @description Execute the first job of the chain to trigger all the chain if the executor specified
  * is the one registered
  */
  public void executeChain(final String identifier) {
    if(identifier == this.executor) {
      this.doExecuteChain();
    }
  }

  /*******************************************************************************************************
  * @description logic to run the chain
  */
  private void doExecuteChain() {
    if(this.latest != null) {
      this.add(this.latest);
      this.latest = null;
    }
    if(this.first != null) {
      this.first.add(this.start);
      this.start = this.first;
      this.first = null;
    }
    if(this.start != null) {
      this.start.executeChain();
      this.start = null;
      this.last = null;
    }
    this.executor = null;
  }  
}