/**
 * sUtil_Test
 *
 * --- Changelog
 *
 * v1.0 Igor Savchenko 2018-08-06
 *
 * @version 1.0
 */
@isTest
public class sUtil_Test {

    @isTest
    static void testU() {
        Test.startTest();

        String strVal;
        Integer intVal;
        Decimal decVal;

        System.assertEquals('zz', sUtil.ifNull(strVal, 'zz'));
        System.assertEquals(3, sUtil.ifNull(intVal, 3));
        System.assertEquals(5, sUtil.ifNull(decVal, 5));

        System.assertEquals(true, sUtil.isDateFormat('12-12-2001'));
        System.assertEquals(true, sUtil.isDateFormat('12.12.2001', 'DD.MM.YYYY'));

        System.assertEquals(Date.newInstance(2001, 7, 12), sUtil.parseDate('12.07.2001', 'DD.MM.YYYY'));
        System.assertEquals(Date.newInstance(2001, 7, 12), sUtil.parseDate('12-07-2001'));

        System.assertEquals('2019-02-01', sUtil.formatDate(Date.newInstance(2019, 2, 1)));

        Test.stopTest();
    }

}