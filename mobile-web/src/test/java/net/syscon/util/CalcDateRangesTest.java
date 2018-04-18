package net.syscon.util;

import org.junit.Test;

import java.time.LocalDate;

import static org.assertj.core.api.Assertions.assertThat;

public class CalcDateRangesTest {

    private static final int TEN_YEARS = 10;
    private CalcDateRanges testClass;

    @Test
    public void testDateRangeIsNullForNoDates() {
        testClass = new CalcDateRanges(null, null,null, TEN_YEARS);
        assertThat(testClass.getDateFrom()).isNull();
        assertThat(testClass.getDateTo()).isNull();
    }

    @Test
    public void testFromAndToDateSetForDobOnly() {
        final LocalDate dob = LocalDate.now().atStartOfDay().toLocalDate();
        testClass = new CalcDateRanges(dob, null,null, TEN_YEARS);
        assertThat(testClass.getDateFrom()).isEqualTo(dob);
        assertThat(testClass.getDateTo()).isEqualTo(dob);
    }

    @Test
    public void testDateRangeCalcLessThan10Years() {
        LocalDate fromDate = LocalDate.now().atStartOfDay().toLocalDate();
        LocalDate toDate = fromDate.plusYears(3);

        testClass = new CalcDateRanges(null, fromDate, toDate, TEN_YEARS);
        assertThat(testClass.getDateFrom()).isEqualTo(fromDate);
        assertThat(testClass.getDateTo()).isEqualTo(toDate);
    }

    @Test
    public void testDateRangeCalcEqual10Years() {
        LocalDate fromDate = LocalDate.now().atStartOfDay().toLocalDate();
        LocalDate toDate = fromDate.plusYears(TEN_YEARS);

        testClass = new CalcDateRanges(null, fromDate, toDate, TEN_YEARS);
        assertThat(testClass.getDateFrom()).isEqualTo(fromDate);
        assertThat(testClass.getDateTo()).isEqualTo(toDate);
    }

    @Test
    public void testDateRangeCalcMoreThan10Years() {
        LocalDate fromDate = LocalDate.now().atStartOfDay().toLocalDate();
        LocalDate toDate = fromDate.plusYears(30);

        testClass = new CalcDateRanges(null, fromDate, toDate, TEN_YEARS);
        assertThat(testClass.getDateFrom()).isEqualTo(fromDate);
        assertThat(testClass.getDateTo()).isNotEqualTo(toDate);
        assertThat(testClass.getDateTo()).isEqualTo(fromDate.plusYears(TEN_YEARS));
    }


    @Test
    public void testDateRangeCalcOnlyFromSpecified() {
        LocalDate fromDate = LocalDate.now().atStartOfDay().toLocalDate();

        testClass = new CalcDateRanges(null, fromDate, null, TEN_YEARS);
        assertThat(testClass.getDateFrom()).isEqualTo(fromDate);
        assertThat(testClass.getDateTo()).isEqualTo(fromDate.plusYears(TEN_YEARS));
    }

    @Test
    public void testDateRangeCalcOnlyToSpecified() {
        LocalDate toDate = LocalDate.now().atStartOfDay().toLocalDate();

        testClass = new CalcDateRanges(null, null, toDate, TEN_YEARS);
        assertThat(testClass.getDateTo()).isEqualTo(toDate);
        assertThat(testClass.getDateFrom()).isEqualTo(toDate.minusYears(TEN_YEARS));
    }
}
