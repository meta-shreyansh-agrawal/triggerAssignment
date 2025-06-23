public with sharing class WorkingDays {
     public static Integer getWorkingDays(Date date1, Date date2){
        if(date1>date2){
            return getWorkingDays(date2, date1);
        }

        // we need to exclude the starting date. therefore, move the date1 forward 1 day, 
        date1 = date1.addDays(1);

        // calcuate number of weeks in between
        Integer daysBetween = date1.daysBetween(date2);

        Integer weeksBetween = daysBetween/7;
        // each week has 5 working days
        Integer currWorkingDays = weeksBetween*5;

        // jump to the closest same weekday to date2
        date1 = date1.addDays(7*weeksBetween);

        Date currDate = date1;
        while(currDate < date2){
            if(isWorkingDay(currDate)) {
                currWorkingDays++;
            }
            currDate = currDate.addDays(1);
        }
        return currWorkingDays;
    }

    private static Boolean isWorkingDay(Date inputDate){
        Integer weekDay = getWeekDay(inputDate);
        if(weekDay!=0 && weekDay!=6) return true;
        return false;
    }

    private static Integer getWeekDay(Date inputDate){
        // 0 means sunday
        // 6 means saturday
        Date weekStart = inputDate.toStartOfWeek();
        return weekStart.daysBetween(inputDate);
    }
}   