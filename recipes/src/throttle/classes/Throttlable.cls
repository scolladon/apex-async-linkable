public inherited sharing class Throttlable {
  protected AsyncLinkable toThrottle;

  public Throttlable(final AsyncLinkable toThrottle) {
    this.toThrottle = toThrottle;
  }

  public Id spawn() {
    final List<AsyncApexJob> relatedAsyncJobs = this.getAsyncJobs();
    if (relatedAsyncJobs.isEmpty()) {
      return this.toThrottle.spawn();
    }
    return relatedAsyncJobs[0].Id;
  }

  private List<AsyncApexJob> getAsyncJobs() {
    final String className = String.valueOf(this.toThrottle).split(':')[0];
    return [
      SELECT Id, JobType
      FROM AsyncApexJob
      WHERE
        Status IN ('Queued', 'Processing', 'Preparing')
        AND ApexClass.Name = :className
      ORDER BY CreatedDate DESC
    ];
  }
}
