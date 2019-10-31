# sobjects_queries - any feedback is highly appreciated!
Allows to do queries to Apex SObjects using dynamic object name, clauses etc.

Examples of usage:

```
// Get list of objects
SObject[] cases = sObj.getList('Case', new String[]{'Name', 'CustomField__c'});
```

```
// Get list of objects with clauses
SObject[] assets = sObj.getList(
    'Asset', new String[]{'Name', 'CustomField__c'},
    new List<sObj.Clause>{
        new sObj.Clause('Name', ''CustomField__c''),
        new sObj.Clause('CustomField__c', new String[]{'Val1', 'Val2', 'Val3'}, 'IN')
    }
);
```

```
// Get map of objects with clauses
Map<String, SObject> accounts = sObj.getMap(
    'Account', new String[]{'Name', 'CustomField__c'},
    new List<sObj.Clause>{
        new sObj.Clause('Name', new String[]{'', ''} , 'IN'),
    },
    'Id'
);
```
