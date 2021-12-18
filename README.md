## Apex AsyncLinkable ![Build](https://github.com/scolladon/apex-async-linkable/actions/workflows/main.yml/badge.svg) [![codecov](https://codecov.io/gh/scolladon/apex-async-linkable/branch/master/graph/badge.svg?token=DFHDV3OCIS)](https://codecov.io/gh/scolladon/apex-async-linkable)

This library provides all the classes required to chain all kind of Async jobs.

## Installation

```bash
$ sfdx force:source:deploy -p chain/src/lib
```

## Usage

1. Create a class and extend the type of the `[AsyncLinkable](https://github.com/scolladon/apex-async-linkable/blob/master/chain/src/lib/classes/AsyncLinkable.cls)` class you require.
   _Your class can have its own constructors and its own attributes of course !_
2. Respect the interface contract and override the `job` method.
   _`start` method must also be overridden for the BatchLink and ScheduleBatchLink class_

The `job` method will contains your business logic. It can access the private attributes of your class (and the protected ones of the base class).

If you need some extra interface to make you're code work, it is up to you to add them (`Database.Stateful`, `Database.AllowsCallouts`, etc).

You're ready to chain apex asynchronous process!

Example for Batchable:

```apex
// Subclass BatchLink for example
public class BatchLink_EXAMPLE extends BatchLink {
  public override Database.QueryLocator start(
    Database.BatchLinkableContext bc
  ) {
    return Database.getQueryLocator('select id from account limit 1');
  }

  public BatchLink_EXAMPLE() {
    super();
  }

  protected override void job() {
    System.Debug('BatchLink_EXAMPLE');
  }
}
```

Example for Queue:

```apex
//Subclass QueueLink for example
public class QueueLink_EXAMPLE extends QueueLink {
  public QueueLink_EXAMPLE() {
    super();
  }

  protected override void job() {
    System.Debug('BatchLink_EXAMPLE');
  }
}
```

Example chaining `BatchLink_EXAMPLE` and `QueueLink_EXAMPLE`;

```apex
// Chain both and execute them
public class Service {
  public static void doService() {
    ChainManager.instance
      .add(new BatchLink_EXAMPLE())
      .add(new QueueLink_EXAMPLE())
      .startChain();
  }
}
```

## Improvement

Implement sub class allowing to handle BatchLink and ScheduleBatchLink with iterable in addition of QueryLocator\

## Versioning

[SemVer](http://semver.org/) is used for versioning.

## Authors

- **Sebastien Colladon** - _Initial work_ - [scolladon](https://github.com/scolladon)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
