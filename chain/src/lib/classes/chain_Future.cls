public inherited sharing abstract class chain_Future extends chain_Method {
  protected override abstract void job();

  public chain_Future() {
    super();
  }

  @Future(callout=true)
  private static void execute(String className) {
    chain_Future aFutureMethod = (chain_Future) Type.forName(className).newInstance();
    aFutureMethod.doExecute();
  }

  public virtual override void spawn() {
    chain_Future.execute(String.valueOf(this).split(':')[0]);
  }

  public void doExecute() {
    super.spawn();
  }

  public override void setNext(chain_Chainable link) {
    if(!(link instanceof chain_Future)) {
      super.setNext(link);
    }
  }
}