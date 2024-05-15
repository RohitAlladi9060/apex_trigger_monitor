/**
 * @author Rohit Alladi
 * @date Mar 2018
 * @group-content ../ApexDocContent/TestClasses.html
 * @description Test class for TriggerMonitor
 **/
@IsTest
private class TriggerMonitorTest {

    /**
     * Method Tested: beforeInsert()
     * | Scenario: Called
     * | Expected Result: Trigger type set
     **/
    static testmethod void beforeInsert_Called_TriggerTypeSet() {
        TriggerMonitor trigMon = TriggerMonitor.getInstance();
        trigMon.start();

        Test.startTest();
        trigMon.beforeInsert('MyTrigger');
        Test.stopTest();

        System.assertEquals('Before Insert', trigMon.triggerMap.get('MyTrigger Before Insert').triggerType, 'Expected triggerType set.');
    }

    static testmethod void beforeInsert_StartNotCalled_TriggerMapNotWrittenTo() {
        TriggerMonitor trigMon = TriggerMonitor.getInstance();
        trigMon.start();

        Test.startTest();
        trigMon.beforeInsert('MyTrigger');
        Test.stopTest();

        System.assert(trigMon.triggerMap.isEmpty(), 'Data should not be recorded until start() method is called.');
    }

    /**
     * Method Tested: beforeInsert()
     * | Scenario: Called twice
     * | Expected Result: Execution count set
     **/
    static testmethod void beforeInsert_CalledTwice_ExecutionCountSet() {
        TriggerMonitor trigMon = TriggerMonitor.getInstance();
        trigMon.start();

        Test.startTest();
        trigMon.beforeInsert('MyTrigger');
        trigMon.beforeInsert('MyTrigger');
        Test.stopTest();

        System.assertEquals(2, trigMon.triggerMap.get('MyTrigger Before Insert').executionCount, 'Expected 2 executions.');
    }

    /**
     * Method Tested: beforeUpdate()
     * | Scenario: Called
     * | Expected Result: Trigger type set
     **/
    static testmethod void beforeUpdate_Called_TriggerTypeSet() {
        TriggerMonitor trigMon = TriggerMonitor.getInstance();
        trigMon.start();

        Test.startTest();
        trigMon.beforeUpdate('MyTrigger');
        Test.stopTest();

        System.assertEquals('Before Update', trigMon.triggerMap.get('MyTrigger Before Update').triggerType, 'Expected triggerType set.');
    }

    /**
     * Method Tested: beforeDelete()
     * | Scenario: Called
     * | Expected Result: Trigger type set
     **/
    static testmethod void beforeDelete_Called_TriggerTypeSet() {
        TriggerMonitor trigMon = TriggerMonitor.getInstance();
        trigMon.start();

        Test.startTest();
        trigMon.beforeDelete('MyTrigger');
        Test.stopTest();

        System.assertEquals('Before Delete', trigMon.triggerMap.get('MyTrigger Before Delete').triggerType, 'Expected triggerType set.');
    }

    static testmethod void afterInsert_Called_TriggerTypeSet() {
        TriggerMonitor trigMon = TriggerMonitor.getInstance();
        trigMon.start();

        Test.startTest();
        trigMon.afterInsert('MyTrigger');
        Test.stopTest();

        System.assertEquals('After Insert', trigMon.triggerMap.get('MyTrigger After Insert').triggerType, 'Expected triggerType set.');
    }

    /**
     * Method Tested: afterUpdate()
     * | Scenario: Called
     * | Expected Result: Trigger type set
     **/
    static testmethod void afterUpdate_Called_TriggerTypeSet() {
        TriggerMonitor trigMon = TriggerMonitor.getInstance();
        trigMon.start();

        Test.startTest();
        trigMon.afterUpdate('MyTrigger');
        Test.stopTest();

        System.assertEquals('After Update', trigMon.triggerMap.get('MyTrigger After Update').triggerType, 'Expected triggerType set.');
    }

    /**
     * Method Tested: afterDelete()
     * | Scenario: Called
     * | Expected Result: Trigger type set
     **/
    static testmethod void afterDelete_Called_TriggerTypeSet() {
        TriggerMonitor trigMon = TriggerMonitor.getInstance();
        trigMon.start();

        Test.startTest();
        trigMon.afterDelete('MyTrigger');
        Test.stopTest();

        System.assertEquals('After Delete', trigMon.triggerMap.get('MyTrigger After Delete').triggerType, 'Expected triggerType set.');
    }

    /**
     * Method Tested: writeToDebugLog
     * | Scenario: Multiple methods called
     * | Expected Result: Flushed log message properly formatted
     **/
    static testmethod void writeToDebugLog_MultipleMethodsCalled_FlushedLogMessageProperlyFormatted() {

        TriggerMonitor trigMon = TriggerMonitor.getInstance();
        trigMon.start();

        trigMon.afterInsert('MyTrigger');
        trigMon.afterInsert('MyTrigger');
        trigMon.beforeUpdate('MyTrigger');
        trigMon.beforeInsert('MyOtherTrigger');

        Test.startTest();
        String logMsg = trigMon.writeToDebugLog();
        Test.stopTest();
        System.assertEquals(
                'TRIGGER MONITOR...\n\tMyTrigger (After Insert): 2\n\tMyTrigger (Before Update): 1\n\tMyOtherTrigger (Before Insert): 1',
                logMsg, 'Log message improperly formmatted.');
    }

}