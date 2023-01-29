public inherited sharing class Debounceable {
  protected AsyncLinkable toThrottle;

  public Debounceable(final AsyncLinkable toThrottle) {
    this.toThrottle = toThrottle;
  }

  public Id spawn() {
    final List<AsyncApexJob> relatedAsyncJobs = this.getAsyncJobs();
    if (relatedAsyncJobs.isEmpty()) {
      return this.toThrottle.spawn();
    }
    FlexQueue.moveJobToEnd(relatedAsyncJobs[0].Id);
    return relatedAsyncJobs[0].Id;
  }

  /*
    public virtual override Id spawn() {
        final List<AsyncApexJob> relatedAsyncJobs = this.getAsyncJobs();
        for(AsyncApexJob aj : relatedAsyncJobs) {
            System.abortJob(aj.Id);
        }
        return this.toThrottle.spawn();
    }
    */

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
