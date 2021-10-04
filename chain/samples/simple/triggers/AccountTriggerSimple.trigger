trigger AccountTriggerSimple on Account(before update, after update) {
  AccountTriggerHandlerSimple.handleTrigger(
    Trigger.new,
    Trigger.old,
    Trigger.operationType
  );
}
