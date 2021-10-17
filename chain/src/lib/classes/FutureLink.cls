public inherited sharing abstract class FutureLink extends AsyncLinkable {
  protected override abstract void job();

  public FutureLink() {
    super();
  }

  @Future(callout=true)
  private static void execute(String className) {
    FutureLink aFutureLinkMethod = (FutureLink) Type.forName(className)
      .newInstance();
    aFutureLinkMethod.doExecute();
  }

  public virtual override Id spawn() {
    FutureLink.execute(String.valueOf(this).split(':')[0]);
    return null; // TODO implement query to get information
    // SELECT Id  FROM AsyncApexJob where MethodName='method_name' And ApexClassId='apex_Id' order by createddate desc
  }

  public void doExecute() {
    this.prepareChaining();
    this.job();
    this.startChain();
  }

  public override void setNext(AsyncLinkable link) {
    if (!(link instanceof FutureLink)) {
      super.setNext(link);
    }
  }
}
