## Apex Chainable
This library provides all the classes required to chain all kind of Async jobs.

## Installation
<a href="https://githubsfdeploy.herokuapp.com?owner=scolladon&repo=apex-chainable">
  <img alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/deploy.png">
</a>


## Usage
Create a class and extend the type of the chainable class you require.
Your class can have its own constructors and its own attributes of course !
Respect the interface contract and override the job method.
You need to override the start method also for the chain_Batch and chain_ScheduleBatch class
The job method will contains your business logic. It can access the private attributes of your class (and the protected ones of the base class).
If you need some extra interface to make you're code work, it is up to you to add them (Database.Stateful, Database.AllowsCallouts, etc).
You're ready to chain ! 
You do not need to override another method except if you really know what you're doing

```apex
// Subclass Batch for example
public class chain_Batch_EXAMPLE extends chain_Batch {
  public override Database.QueryLocator start(Database.BatchableContext bc) {
    return Database.getQueryLocator('select id from account limit 1');
  }

  public chain_Batch_EXAMPLE(){
    super();
  }

  protected override void job() {
    System.Debug('chain_Batch_EXAMPLE');
  }
}

//Subclass Queue for example
public class chain_Queue_EXAMPLE extends chain_Queue {

  public chain_Queue_EXAMPLE(){
    super();
  }

  protected override void job() {
    System.Debug('chain_Batch_EXAMPLE');
  }
}

// Chain both and execute them
public class Service {
  public static void doService() {
    chain_Chainable aChain = new chain_Batch_EXAMPLE();
    aChain.Add(new chain_Queue_EXAMPLE());

    aChain.executeChain();
  }
}
```

## Improvement

Implement sub class allowing to handle Batch and ScheduleBatch with iterable in addition of QueryLocator
Allow to benefit from [this pilot](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_enhanced_future_overview.htm) for the chain_Future class

## Versioning

[SemVer](http://semver.org/) is used for versioning.

## Authors

* **Sebastien Colladon** - *Initial work* - [scolladon](https://github.com/scolladon)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details