@isTest
private class chain_Chainable_TEST {
  @testSetup
  static void setup() {
    insert new Account(name = 'test');
  }

  @isTest
  static void testAll() {
    chain_Chainable aBatch1 = new chain_Batch_TEST();
    chain_Chainable aFuture1 = new chain_Future_TEST();
    chain_Chainable aSchedule1 = new chain_Schedule_TEST('test', '0 0 * * * ?');
    chain_Chainable aFuture2 = new chain_Future_TEST();
    chain_Chainable aFuture3 = new chain_Future_TEST();
    chain_Chainable aScheduleBatch1 = new chain_ScheduleBatch_TEST('test', 1);
    chain_Chainable aFuture4 = new chain_Future_TEST();
    chain_Chainable aQueue1 = new chain_Queue_TEST();

    aBatch1.setNext(aFuture1);
    aFuture1.setNext(aSchedule1);
    aSchedule1.setNext(aFuture2);
    aFuture2.setNext(aFuture3);
    aFuture3.setNext(aScheduleBatch1);
    aScheduleBatch1.setNext(aFuture4);
    aFuture4.setNext(aQueue1);

    test.startTest();
    aBatch1.spawn();
    test.stopTest();
  }

  @isTest
  static void testQueue() {
    chain_Chainable aChainable = new chain_Queue_TEST();

    test.startTest();
    aChainable.spawn();
    test.stopTest();
  }

  @isTest
  static void testScheduleBatch() {
    chain_Chainable aChainable = new chain_ScheduleBatch_TEST('test', 1);

    test.startTest();
    aChainable.spawn();
    test.stopTest();
  }
}
