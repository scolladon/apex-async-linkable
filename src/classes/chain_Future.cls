public inherited sharing abstract class chain_Future extends chain_Method {

  public chain_Future(){
    super();
  }

  protected override abstract void job();

  @Future(callout=true)
  private static void execute(String className) {
    chain_Future aFutureMethod = (chain_Future) Type.forName(className).newInstance();
    aFutureMethod.doExecute();
  }

  public virtual override void executeChain() {
    chain_Future.execute(String.valueOf(this).split(':')[0]);
  }

  public void doExecute() {
    super.executeChain();
  }

  public override chain_Chainable add(chain_Chainable aChain) {
    if(!(aChain instanceof chain_Future)) {
      return super.add(aChain);
    }
    return this;
  }
}