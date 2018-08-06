# sobjects_queries
Allows to do queries to Apex SObjects using dynamic object name, clauses etc.

Examples of usage:

// Get list of objects
SObject[] cases = SO.getList('Case', new String[]{'Id', 'Name'});

// Get list of objects with clauses
SObject[] assets = SO.getList(
    'Asset', new String[]{'Id', 'Name', 'CustomField__c'},
    new List<SO.Clause>{
        new SO.Clause('Name', 'SomeName'),
        new SO.Clause('CustomField__c', new String[]{'Val1', 'Val2', 'Val3'}, 'IN')
    }
);
        
// Get map of objects with clauses
Map<String, SObject> accounts = SO.getMap(
    'Account', new String[]{'Id', 'Name'},
    new List<SO.Clause>{
        new SO.Clause('Name', new String[]{'', ''} , 'IN'),
    },
    'Id'
);
