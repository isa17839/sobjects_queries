/**
 * Q_Test
 *
 * v1.0 Igor Savchenko 2019-02-08
 * 
 * @version 1.0
 */
@isTest
public class Q_Test {
    
    @isTest 
    static void testQ() {
        Test.startTest();
        
        Q.sel('Id').frm('Account').whr('Name = \'qq\'').whr('Name', 'qq').whr('Name', new String[]{'a', 'b'}).order('Name').lmt(3).query();
        Q.sel('Id').frm('Account').whr('Name = \'qq\'').whr('Name', 'qq').lmt(3).queryFirst();

        Test.stopTest();
    }

}