package net.syscon.elite.executablespecification;

import cucumber.api.java.en.And;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import net.syscon.elite.executablespecification.steps.KeyWorkerAllocationSteps;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * BDD step definitions for the key worker endpoints
 */
public class KeyWorkerAllocationsStepDefinitions extends AbstractStepDefinitions {

    @Autowired
    private KeyWorkerAllocationSteps keyworkerSteps;

    @When("^an unallocated offender request is made with agency id \"([^\"]*)\"$")
    public void anUnallocatedOffenderRequestIsMadeWithAgencyId(String agencyId) throws Throwable {
        keyworkerSteps.getUnallocatedOffendersList(agencyId);
    }

    @When("^an unallocated offender request is made$")
    public void anUnallocatedOffenderRequestIsMade() throws Throwable {
        keyworkerSteps.getUnallocatedOffendersList(null);
    }

    @Then("^a list of \"([^\"]*)\" unallocated offenders are returned$")
    public void aListOfUnallocatedOffendersAreReturned(int count) throws Throwable {
        keyworkerSteps.verifyAListOfUnallocatedOffendersIsReturned(count);
    }

    @And("^the list is sorted by lastName asc$")
    public void theListIsSorted() throws Throwable {
        keyworkerSteps.verifyListIsSortedByLastNameAsc();
    }

    @Then("^a resource not found response is received with message \"([^\"]*)\"$")
    public void aResourceNotFoundResponseIsReceivedWithMessage(String message) throws Throwable {
        keyworkerSteps.verifyResourceNotFound();
        keyworkerSteps.verifyErrorUserMessage(message);
    }
}
