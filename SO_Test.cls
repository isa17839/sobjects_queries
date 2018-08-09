/**
 * SO_Test
 *
 * --- Changelog
 *
 * v1.0 Igor Savchenko 2018-07-12
 * v1.1 Igor Savchenko 2018-08-09
 *
 * @version 1.1
 */
@isTest
public class SO_Test {

    @testSetup
    static void setup() {
        Account a = new Account();
        a.LastName = 'Acc1';
        a.ExtId__c = 'abc';
        a.RecordTypeId = [SELECT Id FROM RecordType WHERE SobjectType = 'Account' AND IsPersonType = true LIMIT 1].get(0).Id;
        insert a;
    }

    @isTest
    static void testSo() {
        Account a = [SELECT Id FROM Account LIMIT 1];
        Test.startTest();

        SObject[] accs = SO.getList(
            'Account', new String[]{'LastName'},
            new List<SO.Clause>{
                new SO.Clause('Id', a.Id)
            }
        );
        System.assertEquals(1, accs.size());

        SO.getList('Account', new String[]{'Id'});
        SO.getList('Account', new String[]{'Id'}, new List<SO.Clause>{}, 'Id');
        SO.getSingleField('Account', new String[]{'Id'}, new List<SO.Clause>{});
        SO.getField(accs, 'Id');

        Map<String, SObject> accsMap = SO.getMap(
            'Account', new String[]{'LastName'},
            new List<SO.Clause>{
                new SO.Clause('Id', a.Id)
            },
            'Id'
        );
        System.assertEquals(1, accsMap.size());

        SO.getField(accs, 'Id', new SO.Clause('Id', 'someVal'));
        SO.setField(accs, 'LastName', 'hello!');

        accs = SO.getList(
            'Account', new String[]{'LastName'},
            new List<SO.Clause>{
                new SO.Clause('IsDeleted', 'true')
            }
        );
        System.assertEquals(0, accs.size());

        SO.Clause clause = new SO.Clause('Id', new String[]{'a', 'b', 'c'}, 'IN');
        clause = new SO.Clause('Id', 'someVal', 'IN');

        Test.stopTest();
    }

}