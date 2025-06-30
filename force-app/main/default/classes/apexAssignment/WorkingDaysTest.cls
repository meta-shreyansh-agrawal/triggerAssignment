@isTest
private class WorkingDaysTest {


@IsTest
    static void testGetWorkingDays() {
        Date date1 = Date.newInstance(2023, 1, 1);
        Date date2 = Date.newInstance(2023, 1, 10);
        Integer expected = 6;
        Integer actual = WorkingDays.getWorkingDays(date1, date2);
        System.assertEquals(expected, actual);
    }
}