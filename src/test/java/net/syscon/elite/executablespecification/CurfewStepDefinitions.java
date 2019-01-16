package net.syscon.elite.executablespecification;

import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import net.syscon.elite.executablespecification.steps.CurfewSteps;
import org.springframework.beans.factory.annotation.Autowired;

public class CurfewStepDefinitions extends AbstractStepDefinitions {

    @Autowired
    CurfewSteps curfewSteps;

    @When("^that user requests an update of the HDC status of the latest Offender Curfew for booking \"([^\"]*)\" to \"([^\"]*)\" at \"([^\"]*)\"$")
    public void updateHDCStatus(String bookingIdString, String checksPassed, String dateString) {
        curfewSteps.updateHdcStatus(bookingIdString, checksPassed, dateString);
    }

    @When("^that user requests an update of the HDC approval status of the latest Offender Curfew for booking \"([^\"]*)\" to \"([^\"]*)\" at \"([^\"]*)\"$")
    public void updateHDCApprovalStatus(String bookingIdString, String approvalStatus, String dateString) {
        curfewSteps.updateHdcApprovalStatus(bookingIdString, approvalStatus, dateString);
    }

    @Then("^the response HTTP status should be \"([^\"]*)\"$")
    public void theResponseHTTPStatusIs(String statusString) {
        curfewSteps.verifyHttpStatusCode(Integer.valueOf(statusString));
    }
}