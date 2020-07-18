public inherited sharing class chain_Manager {
  public static final chain_Manager CM = new chain_Manager();

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
  * @description Execute the first job of the chain to trigger all the chain if no executor is registered
  */
  public chain_Manager spawnChain() {
    if(String.isBlank(this.executor)) {
      this.doSpawnChain();
    }
    return this;
  }

  /*******************************************************************************************************
  * @description Execute the first job of the chain to trigger all the chain if the executor specified
  * is the one registered
  */
  public chain_Manager spawnChain(final String identifier) {
    if(identifier == this.executor) {
      this.doSpawnChain();
    }
    return this;
  }

  /*******************************************************************************************************
  * @description logic to run the chain
  */
  private void doSpawnChain() {
    if(this.latest != null) {
      this.add(this.latest);
      this.latest = null;
    }
    if(this.first != null) {
      this.first.setNext(this.start);
      this.start = this.first;
      this.first = null;
    }
    if(this.start != null) {
      this.start.spawn();
      this.start = null;
      this.last = null;
    }
    this.executor = null;
  }

  /*******************************************************************************************************
  * @description Add a chain_Chainable to the chain
  * @param link to add in the chain
  */
  public chain_Manager add(final chain_Chainable link) {
    if(link == null) {
      return this;
    }
    if(this.start == null) {
      this.start = link;
      this.last = this.start;
    } else {
      this.last.setNext(link);
      this.last = link;
    }
    return this;
  }

  /*******************************************************************************************************
  * @description Add a chain_Chainable at the start of the chain
  * @param link to add in the chain
  */
  public chain_Manager addFirst(final chain_Chainable link) {
    this.first = link;
    return this;
  }

  /*******************************************************************************************************
  * @description Add a chain_Chainable that will be executed after all other chain_Chainable no matter when it is added
  * @param aChainable to add in the chain
  */
  public chain_Manager addLast(final chain_Chainable aChainable) {
    this.latest = aChainable;
    return this;
  }

  /*******************************************************************************************************
  * @description Register an executor that will be the only one to be allowed to run the chain
  * @param anExecutor to register
  */
  public chain_Manager registerExecutor(final String anExecutor) {
    if(String.isBlank(this.executor) && String.isNotBlank(anExecutor)){
      this.executor = anExecutor;    
    }
    return this;
  }
}


  /*

  public virtual chain_Chainable pop() {
    chain_Chainable tempChain = this;
    chain_Chainable tempNextChain = tempChain.nextLink;
    while(tempNextChain != null) {
      tempChain = tempNextChain;
      tempNextChain = tempNextChain.nextLink;
    }
    tempChain.nextLink = null;
    return tempNextChain;
  }

  public virtual void link(final chain_Chainable link) {
    this.nextLink = link;
    if(aChain == null) {
      return ;
    }
    chain_Chainable tempChain = this.nextLink;
    while(tempChain != null) {
      tempChain = tempChain.nextLink;
    }
    tempChain = aChain;
    return this;
  }

  public virtual chain_Chainable remove(final chain_Chainable aChain) {
    if(aChain == null || aChain == this) {
      return aChain;
    }

    chain_Chainable tempChain = this;
    while(tempChain != null && tempChain.nextLink != aChain) {
      tempChain = tempChain.nextLink;
    }

    if(tempChain != null) {
      tempChain.nextLink = aChain.nextLink;
    }

    return aChain;
  }

  

  public virtual void shift(final chain_Chainable aChain) {
    
  }

  public virtual chain_Chainable unshift() {
    return this;
  }
  */