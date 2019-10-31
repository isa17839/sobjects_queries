/**
 * sUtil
 *
 * @description
 * This class is basic util class for Apex
 *
 * --- Changelog
 *
 * v1.0 Igor Savchenko 2018-08-06
 *
 * @version 1.0
 */

public class sUtil {

    public static Integer ifNull(Integer actual, Integer ifnull) {
        return actual != null ? actual : ifnull;
    }
    public static Decimal ifNull(Decimal actual, Decimal ifnull) {
        return actual != null ? actual : ifnull;
    }
    public static String ifNull(String actual, String ifnull) {
        return actual != null ? actual : ifnull;
    }

    /**
     * Checks if string is in date format DD-MM-YYYY
     */
    public static Boolean isDateFormat(String str) {
        return Pattern.compile('^[0-9]{2}-[0-9]{2}-[0-9]{4}').matcher(str).matches();
    }

    /**
     * @param format - 2 possible formats: DD-MM-YYYY by default and DD.MM.YYYY
     */
    public static Boolean isDateFormat(String str, String format) {
        if (format == 'DD.MM.YYYY') {
            return Pattern.compile('^[0-9]{2}\\.[0-9]{2}\\.[0-9]{4}').matcher(str).matches();
        }
        return isDateFormat(str);
    }

    /**
     * Parses string date into Date object. Default format is DD-MM-YYYY
     */
    public static Date parseDate(String dateString) {
        return Date.newInstance(Integer.valueOf(dateString.split('-')[2]), Integer.valueOf(dateString.split('-')[1]), Integer.valueOf(dateString.split('-')[0]));
    }

    /**
     * @param format - 2 possible formats: DD-MM-YYYY by default and DD.MM.YYYY
     *
     * @return
     */
    public static Date parseDate(String dateString, String format) {
        if (format == 'DD.MM.YYYY') {
            return Date.newInstance(Integer.valueOf(dateString.split('\\.')[2]), Integer.valueOf(dateString.split('\\.')[1]), Integer.valueOf(dateString.split('\\.')[0]));
        }
        return parseDate(dateString);
    }

    public static String formatDate(Date d) {
        return d.year() + '-' + (d.month() < 10 ? '0' : '') + d.month() + '-' + (d.day() < 10 ? '0' : '') + d.day();
    }

}