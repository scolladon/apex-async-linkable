public with sharing class AccountServiceSimple {
  public static void handleUpdate(final List<Account> accounts) {
    // Handle business logic
    // Share information to external system
    chain_Manager.instance.add(new BigOpportunityCalcul(accounts));
    chain_Manager.instance.spawnChain(); // Not spawned if an executor has been registered
  }

  public static void handleSharing(final List<Account> accounts) {
    // Handle business logic
    // Spawn a sharing calculation
    chain_Manager.instance.add(new AccountSharingDelegate(accounts));
    chain_Manager.instance.spawnChain(); // Not spawned if an executor has been registered
  }

  private class BigOpportunityCalcul extends chain_Queue {
    protected List<Account> accounts;

    public BigOpportunityCalcul(final List<Account> accounts) {
      this.accounts = accounts;
    }

    protected override void job() {
      // Call external API
      System.Debug('Call external API');
    }
  }

  private class AccountSharingDelegate extends chain_Queue {
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
