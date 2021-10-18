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

  public ChainManager add(final AsyncLinkable aLink) {
    if (aLink == null) {
      return this;
    }
    if (this.start == null) {
      this.start = aLink;
    } else {
      this.last.setNext(aLink);
    }

    this.last = getLastLink(aLink);

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
    for (AsyncLinkable aLink : links) {
      this.add(aLink);
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

  public static AsyncLinkable getLastLink(final AsyncLinkable aLink) {
    final LastFetcher aLastFetcher = new LastFetcher();
    aLink?.accept(aLastFetcher);
    return aLastFetcher.getLastLink();
  }

  public static AsyncLinkable[] unchain(final ChainManager chainChainManager) {
    final List<AsyncLinkable> AsyncLinkableArray = unchain(
      chainChainManager?.start
    );
    chainChainManager?.clear();
    return AsyncLinkableArray;
  }

  public static AsyncLinkable[] unchain(final AsyncLinkable aLink) {
    final Unchainer anUnchainer = new UnChainer();
    aLink?.accept(anUnchainer);
    return anUnchainer.getLinks();
  }

  private class UnChainer implements AsyncLinkable.Visitor {
    private List<AsyncLinkable> links;
    public UnChainer() {
      this.links = new List<AsyncLinkable>();
    }

    public void visit(final AsyncLinkable aLink) {
      this.links.Add(aLink);
      if (aLink?.hasNext()) {
        this.visit(aLink.getNext());
      }
      aLink?.setNext(null);
    }

    public List<AsyncLinkable> getLinks() {
      return this.links;
    }
  }

  private class LastFetcher implements AsyncLinkable.Visitor {
    private AsyncLinkable lastLink;
    public LastFetcher() {
    }

    public void visit(final AsyncLinkable aLink) {
      if (aLink != null && aLink?.hasNext()) {
        this.visit(aLink?.getNext());
      } else {
        this.lastLink = aLink;
      }
    }

    public AsyncLinkable getLastLink() {
      return this.lastLink;
    }
  }
}
