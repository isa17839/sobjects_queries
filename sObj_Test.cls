/**
 * sObj_Test
 *
 * --- Changelog
 *
 * v1.0 Igor Savchenko 2018-07-12
 * v1.1 Igor Savchenko 2018-08-09
 *
 * @version 1.1
 */
@isTest
public class sObj_Test {

    @testSetup
    static void setup() {
        Account a = new Account();
        a.LastName = 'Acc1';
        a.RecordTypeId = [SELECT Id FROM RecordType WHERE SobjectType = 'Account' AND IsPersonType = true LIMIT 1].get(0).Id;
        insert a;
    }

    @isTest
    static void testSo() {
        Account a = [SELECT Id FROM Account LIMIT 1];
        Test.startTest();

        SObject[] accs = sObj.getList(
            'Account', new String[]{'LastName'},
            new List<sObj.Clause>{
                new sObj.Clause('Id', a.Id)
            }
        );
        System.assertEquals(1, accs.size());

        sObj.getList('Account', new String[]{'Id'});
        sObj.getList('Account', new String[]{'Id'}, new List<sObj.Clause>{}, 'Id');
        sObj.getSingleField('Account', new String[]{'Id'}, new List<sObj.Clause>{});
        sObj.getField(accs, 'Id');

        Map<String, SObject> accsMap = sObj.getMap(
            'Account', new String[]{'LastName'},
            new List<sObj.Clause>{
                new sObj.Clause('Id', a.Id)
            },
            'Id'
        );
        System.assertEquals(1, accsMap.size());

        sObj.getField(accs, 'Id', new sObj.Clause('Id', 'someVal'));
        sObj.setField(accs, 'LastName', 'hello!');

        accs = sObj.getList(
            'Account', new String[]{'LastName'},
            new List<sObj.Clause>{
                new sObj.Clause('IsDeleted', 'true')
            }
        );
        System.assertEquals(0, accs.size());

        sObj.Clause clause = new sObj.Clause('Id', new String[]{'a', 'b', 'c'}, 'IN');
        clause = new sObj.Clause('Id', 'someVal', 'IN');

        Test.stopTest();
    }

}