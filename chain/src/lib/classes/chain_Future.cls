public inherited sharing abstract class chain_Future extends chain_Chainable {
  protected override abstract void job();

  public chain_Future() {
    super();
  }

  @Future(callout=true)
  private static void execute(String className) {
    chain_Future aFutureMethod = (chain_Future) Type.forName(className)
      .newInstance();
    aFutureMethod.doExecute();
  }

  public virtual override Id spawn() {
    chain_Future.execute(String.valueOf(this).split(':')[0]);
    return null; // TODO implement query to get information
    // SELECT Id  FROM AsyncApexJob where MethodName='method_name' And ApexClassId='apex_Id' order by createddate desc
  }

  public void doExecute() {
    this.prepareChaining();
    this.job();
    this.spawnChain();
  }

  public override void setNext(chain_Chainable link) {
    if (!(link instanceof chain_Future)) {
      super.setNext(link);
    }
  }
}
