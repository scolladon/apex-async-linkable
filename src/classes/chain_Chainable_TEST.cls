@isTest
private class chain_Chainable_TEST {
  @testSetup
  static void setup(){
    insert new Account(name='test');
  }

  @isTest
  static void testAll() {
    chain_Chainable aChainable = new chain_Method_TEST();

    chain_Chainable anotherChainable = new chain_Method_TEST();
    anotherChainable.add(new chain_Method_TEST());

    aChainable
    .Add(anotherChainable)
    .Add(new chain_Method_TEST())
    .Add(new chain_Batch_TEST())
    .Add(new chain_Future_TEST())
    .Add(new chain_Schedule_TEST('test','0 0 * * * ?'))
    .Add(new chain_Future_TEST())
    .Add(new chain_Future_TEST())
    .Add(new chain_ScheduleBatch_TEST('test',1,1))
    .Add(new chain_Future_TEST())
    .Add(new chain_Queue_TEST())
    ;

    test.startTest();
    aChainable.executeChain();
    test.stopTest();
  }

  @isTest
  static void testQueue() {
    chain_Chainable aChainable = new chain_Queue_TEST();

    test.startTest();
    aChainable.executeChain();
    test.stopTest();
  }

    @isTest
  static void testScheduleBatch() {
    chain_Chainable aChainable = new chain_ScheduleBatch_TEST('test',1,-1);

    test.startTest();
    aChainable.executeChain();
    test.stopTest();
  }
}