public inherited sharing abstract class chain_Method extends chain_Chainable {

  public chain_Method(){
    super();
  }

  protected override abstract void job();

  public virtual override void executeChain() {
    try {
      this.job();
    } catch(Exception ex) {
      if(this.canBreak == true) {
        throw ex;
      }
    }
    this.chain();
  }
}