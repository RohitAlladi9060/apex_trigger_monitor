/**
 * @author Rohit Alladi
 * @date Mar 2018
 * @group-content ../ApexDocContent/Classes.html
 * @description Utility to monitor trigger behavior
 **/
public class TriggerMonitor {

    private static TriggerMonitor instance = null;
    private TriggerMonitor() {
        triggerMap = new Map<String, TriggerData>();
    }

    public static TriggerMonitor getInstance() {
        if (instance == null) {
            instance = new TriggerMonitor();
        }
        return instance;
    }

    private Boolean traceStarted = false;

    class TriggerData {
        public TriggerData(String triggerName, String triggerType, Integer executionCount) {
            this.name = triggerName;
            this.triggerType = triggerType;
            this.executionCount = executionCount;
        }
        public String name {get;set;}
        public String triggerType {get;set;}
        public Integer executionCount {get;set;}
    }

    @TestVisible
    private Map<String, TriggerData> triggerMap;


    public Set<String> getTriggerNames() {
        return triggerMap.keySet();
    }

    public String writeToDebugLog() {
        traceStarted = false;

        String msg = 'TRIGGER MONITOR...';
        for (TriggerData trigData : instance.triggerMap.values()) {
            //TODO: Refactor using format. XF
            msg += '\n\t' + trigData.Name + ' (' + trigData.triggerType + '): ' + trigData.executionCount;
        }
        System.debug(msg);
        return msg;
    }

    public void start() {
        traceStarted = true;
    }

    private void updateMap(String key, String triggerName, String triggerType) {
        if (traceStarted) {
            if (instance.triggerMap.get(key) == null) {
                instance.triggerMap.put(key, new TriggerData(triggerName, triggerType, 1));
            } else {
                instance.triggerMap.get(key).executionCount++;
            }
        }
    }

    public void beforeInsert(String triggerName) {

        final String triggerType = 'Before Insert';
        String key = triggerName + ' ' + triggerType;
        updateMap(key, triggerName, triggerType);
    }

    public void beforeUpdate(String triggerName) {
        final String triggerType = 'Before Update';
        String key = triggerName + ' ' + triggerType;
        updateMap(key, triggerName, triggerType);
    }

    public void beforeDelete(String triggerName) {
        final String triggerType = 'Before Delete';
        String key = triggerName + ' ' + triggerType;
        updateMap(key, triggerName, triggerType);
    }

    public void afterInsert(String triggerName) {
        final String triggerType = 'After Insert';
        String key = triggerName + ' ' + triggerType;
        updateMap(key, triggerName, triggerType);
    }

    public void afterUpdate(String triggerName) {
        final String triggerType = 'After Update';
        String key = triggerName + ' ' + triggerType;
        updateMap(key, triggerName, triggerType);
    }

    public void afterDelete(String triggerName) {
        final String triggerType = 'After Delete';
        String key = triggerName + ' ' + triggerType;
        updateMap(key, triggerName, triggerType);
    }

    public void afterUndelete(String triggerName) {
        final String triggerType = 'After Undelete';
        String key = triggerName + ' ' + triggerType;
        updateMap(key, triggerName, triggerType);
    }
}