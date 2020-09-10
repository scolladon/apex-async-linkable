// It works like a LinkedList
public inherited sharing class chain_Manager {
  public static final chain_Manager instance = new chain_Manager();

  protected chain_Chainable start;
  protected chain_Chainable last;

  protected String executor;

  public chain_Manager() {
  }

  public chain_Manager(final String anExecutor) {
    this.registerExecutor(anExecutor);
  }

  /*******************************************************************************************************
   * @description Register an executor that will be the only one to be allowed to run the chain
   * @param anExecutor to register
   */
  public chain_Manager registerExecutor(final String anExecutor) {
    if (String.isBlank(this.executor) && String.isNotBlank(anExecutor)) {
      this.executor = anExecutor;
    }
    return this;
  }

  /*******************************************************************************************************
   * @description Execute the first job of the chain to trigger all the chain if no executor is registered
   */
  public Id spawnChain() {
    if (String.isBlank(this.executor)) {
      return this.doSpawnChain();
    }
    return null;
  }

  /*******************************************************************************************************
   * @description Execute the first job of the chain to trigger all the chain if the executor specified
   * is the one registered
   */
  public Id spawnChain(final String identifier) {
    if (identifier == this.executor) {
      return this.doSpawnChain();
    }
    return null;
  }

  /*******************************************************************************************************
   * @description logic to run the chain
   */
  private Id doSpawnChain() {
    Id jobId;
    if (this.start != null) {
      jobId = this.start.spawn();
      this.clear();
    }
    this.executor = null;
    return jobId;
  }

  public chain_Manager add(final chain_Chainable link) {
    if (link == null) {
      return this;
    }
    if (this.start == null) {
      this.start = link;
    } else {
      this.last.setNext(link);
    }
    chain_Chainable tmpLink = link;
    while (tmpLink.hasNext()) {
      tmpLink = tmpLink.getNext();
    }
    this.last = tmpLink;

    return this;
  }

  public chain_Manager add(final chain_Manager chainManager) {
    if (chainManager == null) {
      return this;
    }
    return this.add(chainManager.start);
  }

  public chain_Manager add(final chain_Chainable[] links) {
    if (links == null) {
      return this;
    }
    for (chain_Chainable link : links) {
      this.add(link);
    }
    return this;
  }

  public chain_Manager add(final chain_Manager[] chainManagers) {
    if (chainManagers == null) {
      return this;
    }
    for (chain_Manager chainManager : chainManagers) {
      this.add(chainManager);
    }

    return this;
  }

  public chain_Manager clear() {
    this.start = null;
    this.last = null;

    return this;
  }

  public static chain_Chainable getLastLink(final chain_Chainable link) {
    if (link == null) {
      return null;
    }
    chain_Chainable tmpLink = link;
    while (tmpLink.hasNext()) {
      tmpLink = tmpLink.getNext();
    }
    return tmpLink;
  }

  public static chain_Chainable[] unchain(final chain_Manager chainManager) {
    final List<chain_Chainable> chainableArray = unchain(chainManager.start);
    chainManager.clear();
    return chainableArray;
  }

  public static chain_Chainable[] unchain(final chain_Chainable link) {
    final List<chain_Chainable> chainableArray = new List<chain_Chainable>();
    chain_Chainable tmpLink = link;
    chain_Chainable currentLink;
    while (tmpLink != null) {
      currentLink = tmpLink;
      tmpLink = currentLink.getNext();
      currentLink.setNext(null);
      chainableArray.add(currentLink);
    }
    return chainableArray;
  }
}
