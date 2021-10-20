## Apex AsyncLinkable

This library provides all the classes required to chain all kind of Async jobs.

## Installation

```bash
$ sfdx force:source:deploy -p path/to/source
```

## Usage

Create a class and extend the type of the AsyncLinkable class you require.\
Your class can have its own constructors and its own attributes of course !\
Respect the interface contract and override the job method.\
You need to override the start method also for the BatchLink and ScheduleBatchLink class\
The job method will contains your business logic. It can access the private attributes of your class (and the protected ones of the base class).\
If you need some extra interface to make you're code work, it is up to you to add them (Database.Stateful, Database.AllowsCallouts, etc).\
You're ready to chain !\
You do not need to override another method except if you really know what you're doing\

```apex
// Subclass BatchLink for example
public class BatchLink_EXAMPLE extends BatchLink {
  public override Database.QueryLocator start(Database.BatchLinkableContext bc) {
    return Database.getQueryLocator('select id from account limit 1');
  }

  public BatchLink_EXAMPLE(){
    super();
  }

  protected override void job() {
    System.Debug('BatchLink_EXAMPLE');
  }
}

//Subclass QueueLink for example
public class QueueLink_EXAMPLE extends QueueLink {

  public QueueLink_EXAMPLE(){
    super();
  }

  protected override void job() {
    System.Debug('BatchLink_EXAMPLE');
  }
}

// Chain both and execute them
public class Service {
  public static void doService() {
    AsyncLinkable aChain = new BatchLink_EXAMPLE();
    aChain.Add(new QueueLink_EXAMPLE());

    aChain.startChain();
  }
}
```

## Improvement

Implement sub class allowing to handle BatchLink and ScheduleBatchLink with iterable in addition of QueryLocator\
Allow to benefit from [this pilot](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_enhanced_FutureLink_overview.htm) for the FutureLink class

## Versioning

[SemVer](http://semver.org/) is used for versioning.

## Authors

- **Sebastien Colladon** - _Initial work_ - [scolladon](https://github.com/scolladon)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
