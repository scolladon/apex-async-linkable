public with sharing class AccountServiceSimple {
  public static void handleUpdate(final List<Account> accounts) {
    // Handle business logic
    // Share information to external system
    ChainManager.instance.add(new BigOpportunityProcessing(accounts));
    ChainManager.instance.startChain(); // Not spawned if an executor has been registered
  }

  public static void handleSharing(final List<Account> accounts) {
    // Handle business logic
    // Spawn a sharing calculation
    ChainManager.instance.add(new AccountSharingDelegate(accounts));
    ChainManager.instance.startChain(); // Not spawned if an executor has been registered
  }

  private class BigOpportunityProcessing extends QueueLink {
    protected List<Account> accounts;

    public BigOpportunityProcessing(final List<Account> accounts) {
      this.accounts = accounts;
    }

    protected override void job() {
      // Call external API
      System.Debug('Call external API');
    }
  }

  private class AccountSharingDelegate extends QueueLink {
    protected List<Account> accounts;

    public AccountSharingDelegate(final List<Account> accounts) {
      this.accounts = accounts;
    }

    protected override void job() {
      // Share Accounts
      System.Debug('Share Accounts');
    }
  }
}
