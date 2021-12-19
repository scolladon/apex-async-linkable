@iStest
private class AsyncLinkIterableTest {
  @IsTest
  static void hasNext_givenNull_returnFalse() {
    // Arrange
    final Iterator<AsyncLinkable> sut = new AsyncLinkIterable(null).iterator();

    // Assert
    System.assertEquals(false, sut.hasNext());
    System.assertEquals(false, sut.hasNext());
  }

  @IsTest
  static void hasNext_given1Link_returnTrueThenFalse() {
    // Arrange
    final AsyncLinkable link = new TestLink();
    final Iterator<AsyncLinkable> sut = new AsyncLinkIterable(link).iterator();

    // Assert
    System.assertEquals(true, sut.hasNext());
    System.assertEquals(true, sut.hasNext());
    sut.next();
    System.assertEquals(false, sut.hasNext());
    System.assertEquals(false, sut.hasNext());
  }

  @IsTest
  static void hasNext_given2Links_returnTrueThenTrueThenFalse() {
    // Arrange
    final AsyncLinkable link = new TestLink();
    link.setNext(new TestLink());
    final Iterator<AsyncLinkable> sut = new AsyncLinkIterable(link).iterator();

    // Assert
    System.assertEquals(true, sut.hasNext());
    System.assertEquals(true, sut.hasNext());
    sut.next();
    System.assertEquals(true, sut.hasNext());
    System.assertEquals(true, sut.hasNext());
    sut.next();
    System.assertEquals(false, sut.hasNext());
    System.assertEquals(false, sut.hasNext());
  }

  @IsTest
  static void next_givenNull_returnNullThenReturnNull() {
    // Arrange
    final Iterator<AsyncLinkable> sut = new AsyncLinkIterable(null).iterator();

    // Assert
    System.assertEquals(null, sut.next());
    System.assertEquals(null, sut.next());
  }

  @IsTest
  static void next_given1Link_returnLinkThenReturnNull() {
    // Arrange
    final AsyncLinkable link = new TestLink();
    final Iterator<AsyncLinkable> sut = new AsyncLinkIterable(link).iterator();

    // Assert
    System.assertEquals(link, sut.next());
    System.assertEquals(null, sut.next());
  }

  @IsTest
  static void next_given2Link_returnSecondLink() {
    // Arrange
    final AsyncLinkable link1 = new TestLink();
    final AsyncLinkable link2 = new TestLink();
    link1.setNext(link2);
    final Iterator<AsyncLinkable> sut = new AsyncLinkIterable(link1).iterator();

    // Assert
    System.assertEquals(link1, sut.next());
    System.assertEquals(link2, sut.next());
    System.assertEquals(false, sut.hasNext());
    System.assertEquals(null, sut.next());
    System.assertEquals(false, sut.hasNext());
  }

  private class TestLink extends QueueLink {
    protected override void job() {
      System.Assert(true);
    }
  }
}
