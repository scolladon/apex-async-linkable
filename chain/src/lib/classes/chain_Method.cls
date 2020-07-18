public inherited sharing abstract class chain_Method extends chain_Chainable {
  protected override abstract void job();

  public chain_Method(){
    super();
  }

  public virtual override void spawn() {
    this.prepareChaining();
    this.job();
    this.spawnChain();
  }
}