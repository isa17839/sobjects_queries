/**
 * U_Test
 *
 * --- Changelog
 *
 * v1.0 Igor Savchenko 2018-08-06
 *
 * @version 1.0
 */
@isTest
public class U_Test {

    @isTest
    static void testU() {
        Test.startTest();

        String strVal;
        Integer intVal;
        Decimal decVal;

        System.assertEquals('zz', U.ifNull(strVal, 'zz'));
        System.assertEquals(3, U.ifNull(intVal, 3));
        System.assertEquals(5, U.ifNull(decVal, 5));

        System.assertEquals(true, U.isDateFormat('12-12-2001'));
        System.assertEquals(true, U.isDateFormat('12.12.2001', 'DD.MM.YYYY'));

        Test.stopTest();
    }

}