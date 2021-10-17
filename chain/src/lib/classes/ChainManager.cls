// It works like a LinkedList
public inherited sharing class ChainManager {
  private static ChainManager privateInstance;
  public static final ChainManager instance {
    get {
      if (privateInstance == null) {
        privateInstance = new ChainManager();
      }
      return privateInstance;
    }
    private set;
  }

  protected AsyncLinkable start;
  protected AsyncLinkable last;

  protected String executor;

  public ChainManager() {
  }

  public ChainManager(final String anExecutor) {
    this.registerExecutor(anExecutor);
  }

  /*******************************************************************************************************
   * @description Register an executor that will be the only one to be allowed to run the chain
   * @param anExecutor to register
   */
  public ChainManager registerExecutor(final String anExecutor) {
    if (String.isBlank(this.executor) && String.isNotBlank(anExecutor)) {
      this.executor = anExecutor;
    }
    return this;
  }

  /*******************************************************************************************************
   * @description Execute the first job of the chain to trigger all the chain if no executor is registered
   */
  public Id startChain() {
    if (String.isBlank(this.executor)) {
      return this.dostartChain();
    }
    return null;
  }

  /*******************************************************************************************************
   * @description Execute the first job of the chain to trigger all the chain if the executor specified
   * is the one registered
   */
  public Id startChain(final String identifier) {
    if (identifier == this.executor) {
      return this.dostartChain();
    }
    return null;
  }

  /*******************************************************************************************************
   * @description logic to run the chain
   */
  private Id doStartChain() {
    Id jobId;
    if (this.start != null) {
      jobId = this.start.spawn();
      this.clear();
    }
    this.executor = null;
    return jobId;
  }

  public ChainManager add(final AsyncLinkable link) {
    if (link == null) {
      return this;
    }
    if (this.start == null) {
      this.start = link;
    } else {
      this.last.setNext(link);
    }
    AsyncLinkable tmpLink = link;
    while (tmpLink.hasNext()) {
      tmpLink = tmpLink.getNext();
    }
    this.last = tmpLink;

    return this;
  }

  public ChainManager add(final ChainManager chainChainManager) {
    if (chainChainManager == null) {
      return this;
    }
    return this.add(chainChainManager.start);
  }

  public ChainManager add(final AsyncLinkable[] links) {
    if (links == null) {
      return this;
    }
    for (AsyncLinkable link : links) {
      this.add(link);
    }
    return this;
  }

  public ChainManager add(final ChainManager[] chainChainManagers) {
    if (chainChainManagers == null) {
      return this;
    }
    for (ChainManager chainChainManager : chainChainManagers) {
      this.add(chainChainManager);
    }

    return this;
  }

  public ChainManager clear() {
    this.start = null;
    this.last = null;

    return this;
  }

  public static AsyncLinkable getLastLink(final AsyncLinkable link) {
    if (link == null) {
      return null;
    }
    AsyncLinkable tmpLink = link;
    while (tmpLink.hasNext()) {
      tmpLink = tmpLink.getNext();
    }
    return tmpLink;
  }

  public static AsyncLinkable[] unchain(final ChainManager chainChainManager) {
    final List<AsyncLinkable> AsyncLinkableArray = unchain(
      chainChainManager.start
    );
    chainChainManager.clear();
    return AsyncLinkableArray;
  }

  public static AsyncLinkable[] unchain(final AsyncLinkable aLink) {
    final Unchainer anUnchainer = new UnChainer();
    return anUnchainer.unchain(aLink);
  }

  private class UnChainer implements AsyncLinkable.Visitor {
    private List<AsyncLinkable> links;
    public UnChainer() {
      this.links = new List<AsyncLinkable>();
    }

    public void visit(final AsyncLinkable aLink) {
      this.links.Add(aLink);
      if (aLink.hasNext()) {
        this.visit(aLink.getNext());
      }
      aLink.setNext(null);
    }

    List<AsyncLinkable> unchain(final AsyncLinkable aLink) {
      this.visit(aLink);
      return this.links;
    }
  }
}
