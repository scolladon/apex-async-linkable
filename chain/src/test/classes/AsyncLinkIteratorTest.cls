@iStest
private class AsyncLinkIteratorTest {
  @IsTest
  static void hasNext_givenNull_returnFalse() {
    // Arrange
    final Iterator<AsyncLinkable> sut = new AsyncLinkIterator(null);

    // Assert
    Assert.isFalse(sut.hasNext());
    Assert.isFalse(sut.hasNext());
  }

  @IsTest
  static void hasNext_given1Link_returnTrueThenFalse() {
    // Arrange
    final AsyncLinkable link = new TestLink();
    final Iterator<AsyncLinkable> sut = new AsyncLinkIterator(link);

    // Assert
    Assert.isTrue(sut.hasNext());
    Assert.isTrue(sut.hasNext());
    sut.next();
    Assert.isFalse(sut.hasNext());
    Assert.isFalse(sut.hasNext());
  }

  @IsTest
  static void hasNext_given2Links_returnTrueThenTrueThenFalse() {
    // Arrange
    final AsyncLinkable link = new TestLink();
    link.setNext(new TestLink());
    final Iterator<AsyncLinkable> sut = new AsyncLinkIterator(link);

    // Assert
    Assert.isTrue(sut.hasNext());
    Assert.isTrue(sut.hasNext());
    sut.next();
    Assert.isTrue(sut.hasNext());
    Assert.isTrue(sut.hasNext());
    sut.next();
    Assert.isFalse(sut.hasNext());
    Assert.isFalse(sut.hasNext());
  }

  @IsTest
  static void next_givenNull_returnNullThenReturnNull() {
    // Arrange
    final Iterator<AsyncLinkable> sut = new AsyncLinkIterator(null);

    // Assert
    Assert.isNull(sut.next());
    Assert.isNull(sut.next());
  }

  @IsTest
  static void next_given1Link_returnLinkThenReturnNull() {
    // Arrange
    final AsyncLinkable link = new TestLink();
    final Iterator<AsyncLinkable> sut = new AsyncLinkIterator(link);

    // Assert
    Assert.areEqual(link, sut.next());
    Assert.isNull(sut.next());
  }

  @IsTest
  static void next_given2Link_returnSecondLink() {
    // Arrange
    final AsyncLinkable link1 = new TestLink();
    final AsyncLinkable link2 = new TestLink();
    link1.setNext(link2);
    final Iterator<AsyncLinkable> sut = new AsyncLinkIterator(link1);

    // Assert
    Assert.areEqual(link1, sut.next());
    Assert.areEqual(link2, sut.next());
    Assert.isFalse(sut.hasNext());
    Assert.isNull(sut.next());
    Assert.isFalse(sut.hasNext());
  }

  private class TestLink extends QueueLink {
    protected override void job() {
    }
  }
}
