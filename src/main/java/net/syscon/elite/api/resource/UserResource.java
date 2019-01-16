package net.syscon.elite.api.resource;

import io.swagger.annotations.*;
import net.syscon.elite.api.model.*;
import net.syscon.elite.api.support.Order;
import net.syscon.elite.api.support.Page;
import net.syscon.elite.api.support.ResponseDelegate;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.List;

@Api(tags = {"/users"})
@SuppressWarnings("unused")
public interface UserResource {

    @DELETE
    @Path("/{username}/caseload/{caseload}/access-role/{roleCode}")
    @Consumes({ "application/json" })
    @Produces({ "application/json" })
    @ApiOperation(value = "Remove the given access role from the user.", notes = "Remove the given access role from the user.", nickname="removeUsersAccessRoleForCaseload")
    @ApiResponses(value = { 
        @ApiResponse(code = 200, message = ""),
        @ApiResponse(code = 404, message = "") })
    RemoveUsersAccessRoleForCaseloadResponse removeUsersAccessRoleForCaseload(@ApiParam(value = "The username of the user.", required = true) @PathParam("username") String username,
                                                                              @ApiParam(value = "Caseload Id", required = true) @PathParam("caseload") String caseload,
                                                                              @ApiParam(value = "access role code", required = true) @PathParam("roleCode") String roleCode);

    @GET
    @Path("/")
    @Consumes({ "application/json" })
    @Produces({ "application/json" })
    @ApiOperation(value = "Get user details.", notes = "Get user details.", nickname="getUsers")
    @ApiResponses(value = {
        @ApiResponse(code = 200, message = "OK", response = UserDetail.class, responseContainer = "List"),
        @ApiResponse(code = 400, message = "Invalid request.", response = ErrorResponse.class, responseContainer = "List"),
        @ApiResponse(code = 404, message = "Requested resource not found.", response = ErrorResponse.class, responseContainer = "List"),
        @ApiResponse(code = 500, message = "Unrecoverable error occurred whilst processing request.", response = ErrorResponse.class, responseContainer = "List") })
    GetUsersResponse getUsers(@ApiParam(value = "Filter results by first name and/or username and/or last name of staff member.") @QueryParam("nameFilter") String nameFilter,
                              @ApiParam(value = "Filter results by access role") @QueryParam("accessRole") String accessRole,
                              @ApiParam(value = "Requested offset of first record in returned collection of user records.", defaultValue = "0") @HeaderParam("Page-Offset") Long pageOffset,
                              @ApiParam(value = "Requested limit to number of user records returned.", defaultValue = "10") @HeaderParam("Page-Limit") Long pageLimit,
                              @ApiParam(value = "Comma separated list of one or more of the following fields - <b>firstName, lastName</b>") @HeaderParam("Sort-Fields") String sortFields,
                              @ApiParam(value = "Sort order (ASC or DESC) - defaults to ASC.", defaultValue = "ASC") @HeaderParam("Sort-Order") Order sortOrder);

    @GET
    @Path("/access-roles/caseload/{caseload}/access-role/{roleCode}")
    @Consumes({ "application/json" })
    @Produces({ "application/json" })
    @ApiOperation(value = "List of users who have the named role at the named caseload", notes = "List of users who have the named role at the named caseload", nickname="getAllUsersHavingRoleAtCaseload")
    @ApiResponses(value = {
        @ApiResponse(code = 200, message = "OK", response = String.class, responseContainer = "List"),
        @ApiResponse(code = 400, message = "Invalid request.", response = ErrorResponse.class, responseContainer = "List"),
        @ApiResponse(code = 404, message = "Requested resource not found.", response = ErrorResponse.class, responseContainer = "List"),
        @ApiResponse(code = 500, message = "Unrecoverable error occurred whilst processing request.", response = ErrorResponse.class, responseContainer = "List") })
    GetAllUsersHavingRoleAtCaseloadResponse getAllUsersHavingRoleAtCaseload(@ApiParam(value = "Caseload Id", required = true) @PathParam("caseload") String caseload,
                                                                            @ApiParam(value = "access role code", required = true) @PathParam("roleCode") String roleCode);

    @GET
    @Path("/caseload/{caseload}")
    @Consumes({ "application/json" })
    @Produces({ "application/json" })
    @ApiOperation(value = "Get user details by prison.", notes = "Get user details by prison.", nickname="getUsersByCaseLoad")
    @ApiResponses(value = {
        @ApiResponse(code = 200, message = "OK", response = UserDetail.class, responseContainer = "List"),
        @ApiResponse(code = 400, message = "Invalid request.", response = ErrorResponse.class, responseContainer = "List"),
        @ApiResponse(code = 404, message = "Requested resource not found.", response = ErrorResponse.class, responseContainer = "List"),
        @ApiResponse(code = 500, message = "Unrecoverable error occurred whilst processing request.", response = ErrorResponse.class, responseContainer = "List") })
    GetUsersByCaseLoadResponse getUsersByCaseLoad(@ApiParam(value = "The agency (prison) id.", required = true) @PathParam("caseload") String caseload,
                                                  @ApiParam(value = "Filter results by first name and/or username and/or last name of staff member.") @QueryParam("nameFilter") String nameFilter,
                                                  @ApiParam(value = "Filter results by access role") @QueryParam("accessRole") String accessRole,
                                                  @ApiParam(value = "Requested offset of first record in returned collection of caseload records.", defaultValue = "0") @HeaderParam("Page-Offset") Long pageOffset,
                                                  @ApiParam(value = "Requested limit to number of caseload records returned.", defaultValue = "10") @HeaderParam("Page-Limit") Long pageLimit,
                                                  @ApiParam(value = "Comma separated list of one or more of the following fields - <b>firstName, lastName</b>") @HeaderParam("Sort-Fields") String sortFields,
                                                  @ApiParam(value = "Sort order (ASC or DESC) - defaults to ASC.", defaultValue = "ASC") @HeaderParam("Sort-Order") Order sortOrder);

    @GET
    @Path("/local-administrator/caseload/{caseload}")
    @Consumes({ "application/json" })
    @Produces({ "application/json" })
    @ApiOperation(value = "Get user details for local administrators by prison.", notes = "Get user details for local administrators by prison.", nickname="getLocalAdministratorUsersByCaseLoad")
    @ApiResponses(value = {
        @ApiResponse(code = 200, message = "OK", response = UserDetail.class, responseContainer = "List"),
        @ApiResponse(code = 400, message = "Invalid request.", response = ErrorResponse.class, responseContainer = "List"),
        @ApiResponse(code = 404, message = "Requested resource not found.", response = ErrorResponse.class, responseContainer = "List"),
        @ApiResponse(code = 500, message = "Unrecoverable error occurred whilst processing request.", response = ErrorResponse.class, responseContainer = "List") })
    GetLocalAdministratorUsersByCaseLoadResponse getLocalAdministratorUsersByCaseLoad(@ApiParam(value = "The agency (prison) id.", required = true) @PathParam("caseload") String caseload,
                                                                                      @ApiParam(value = "Filter results by first name and/or username and/or last name of staff member.") @QueryParam("nameFilter") String nameFilter,
                                                                                      @ApiParam(value = "Filter results by access role") @QueryParam("accessRole") String accessRole,
                                                                                      @ApiParam(value = "Requested offset of first record in returned collection of caseload records.", defaultValue = "0") @HeaderParam("Page-Offset") Long pageOffset,
                                                                                      @ApiParam(value = "Requested limit to number of caseload records returned.", defaultValue = "10") @HeaderParam("Page-Limit") Long pageLimit,
                                                                                      @ApiParam(value = "Comma separated list of one or more of the following fields - <b>firstName, lastName</b>") @HeaderParam("Sort-Fields") String sortFields,
                                                                                      @ApiParam(value = "Sort order (ASC or DESC) - defaults to ASC.", defaultValue = "ASC") @HeaderParam("Sort-Order") Order sortOrder);

    @GET
    @Path("/me")
    @Consumes({ "application/json" })
    @Produces({ "application/json" })
    @ApiOperation(value = "Current user detail.", notes = "Current user detail.", nickname="getMyUserInformation")
    @ApiResponses(value = {
        @ApiResponse(code = 200, message = "OK", response = UserDetail.class),
        @ApiResponse(code = 400, message = "Invalid request.", response = ErrorResponse.class),
        @ApiResponse(code = 404, message = "Requested resource not found.", response = ErrorResponse.class),
        @ApiResponse(code = 500, message = "Unrecoverable error occurred whilst processing request.", response = ErrorResponse.class) })
    GetMyUserInformationResponse getMyUserInformation();

    @GET
    @Path("/me/bookingAssignments")
    @Consumes({ "application/json" })
    @Produces({ "application/json" })
    @Deprecated
    @ApiOperation(value = "List of offender bookings assigned to current user.", notes = "Deprecated: Use <b>/bookings?iepLevel=true&offenderNo=&offenderNo=</b> instead. This API will be removed in a future release as keyworker holds the relationship to offender", nickname="getMyAssignments")
    @ApiResponses(value = {
        @ApiResponse(code = 200, message = "OK", response = OffenderBooking.class, responseContainer = "List"),
        @ApiResponse(code = 400, message = "Invalid request.", response = ErrorResponse.class, responseContainer = "List"),
        @ApiResponse(code = 404, message = "Requested resource not found.", response = ErrorResponse.class, responseContainer = "List"),
        @ApiResponse(code = 500, message = "Unrecoverable error occurred whilst processing request.", response = ErrorResponse.class, responseContainer = "List") })
    GetMyAssignmentsResponse getMyAssignments(@ApiParam(value = "Requested offset of first record in returned collection of bookingAssignment records.", defaultValue = "0") @HeaderParam("Page-Offset") Long pageOffset,
                                              @ApiParam(value = "Requested limit to number of bookingAssignment records returned.", defaultValue = "10") @HeaderParam("Page-Limit") Long pageLimit);

    @GET
    @Path("/me/caseLoads")
    @Consumes({ "application/json" })
    @Produces({ "application/json" })
    @ApiOperation(value = "List of caseloads accessible to current user.", notes = "List of caseloads accessible to current user.", nickname="getMyCaseLoads")
    @ApiResponses(value = {
        @ApiResponse(code = 200, message = "OK", response = CaseLoad.class, responseContainer = "List"),
        @ApiResponse(code = 400, message = "Invalid request.", response = ErrorResponse.class, responseContainer = "List"),
        @ApiResponse(code = 404, message = "Requested resource not found.", response = ErrorResponse.class, responseContainer = "List"),
        @ApiResponse(code = 500, message = "Unrecoverable error occurred whilst processing request.", response = ErrorResponse.class, responseContainer = "List") })
    GetMyCaseLoadsResponse getMyCaseLoads(@ApiParam(value = "If set to true then all caseloads are returned", defaultValue = "false") @QueryParam("allCaseloads") boolean allCaseloads);

    @GET
    @Path("/me/caseNoteTypes")
    @Consumes({ "application/json" })
    @Produces({ "application/json" })
    @ApiOperation(value = "List of all case note types (with sub-types) accessible to current user (and based on working caseload).", notes = "List of all case note types (with sub-types) accessible to current user (and based on working caseload).", nickname="getMyCaseNoteTypes")
    @ApiResponses(value = {
        @ApiResponse(code = 200, message = "OK", response = ReferenceCode.class, responseContainer = "List"),
        @ApiResponse(code = 400, message = "Invalid request.", response = ErrorResponse.class, responseContainer = "List"),
        @ApiResponse(code = 404, message = "Requested resource not found.", response = ErrorResponse.class, responseContainer = "List"),
        @ApiResponse(code = 500, message = "Unrecoverable error occurred whilst processing request.", response = ErrorResponse.class, responseContainer = "List") })
    GetMyCaseNoteTypesResponse getMyCaseNoteTypes(@ApiParam(value = "Comma separated list of one or more of the following fields - <b>code, activeFlag, description</b>") @HeaderParam("Sort-Fields") String sortFields,
                                                  @ApiParam(value = "Sort order (ASC or DESC) - defaults to ASC.", defaultValue = "ASC") @HeaderParam("Sort-Order") Order sortOrder);

    @GET
    @Path("/me/locations")
    @Consumes({ "application/json" })
    @Produces({ "application/json" })
    @ApiOperation(value = "List of locations accessible to current user.", notes = "List of locations accessible to current user.", nickname="getMyLocations")
    @ApiResponses(value = {
        @ApiResponse(code = 200, message = "OK", response = Location.class, responseContainer = "List"),
        @ApiResponse(code = 400, message = "Invalid request.", response = ErrorResponse.class, responseContainer = "List"),
        @ApiResponse(code = 404, message = "Requested resource not found.", response = ErrorResponse.class, responseContainer = "List"),
        @ApiResponse(code = 500, message = "Unrecoverable error occurred whilst processing request.", response = ErrorResponse.class, responseContainer = "List") })
    GetMyLocationsResponse getMyLocations();

    @GET
    @Path("/me/roles")
    @Consumes({ "application/json" })
    @Produces({ "application/json" })
    @ApiOperation(value = "List of roles for current user.", notes = "List of roles for current user.", nickname="getMyRoles")
    @ApiResponses(value = {
        @ApiResponse(code = 200, message = "OK", response = UserRole.class, responseContainer = "List"),
        @ApiResponse(code = 400, message = "Invalid request.", response = ErrorResponse.class, responseContainer = "List"),
        @ApiResponse(code = 404, message = "Requested resource not found.", response = ErrorResponse.class, responseContainer = "List"),
        @ApiResponse(code = 500, message = "Unrecoverable error occurred whilst processing request.", response = ErrorResponse.class, responseContainer = "List") })
    GetMyRolesResponse getMyRoles(@ApiParam(value = "If set to true then all roles are returned rather than just API roles", defaultValue = "false") @QueryParam("allRoles") boolean allRoles);

    @GET
    @Path("/staff/{staffId}")
    @Consumes({ "application/json" })
    @Produces({ "application/json" })
    @Deprecated
    @ApiOperation(value = "Staff detail.", notes = "Deprecated: Use <b>/staff/{staffId}</b> instead. This API will be removed in a future release.", nickname="getStaffDetail")
    @ApiResponses(value = {
        @ApiResponse(code = 200, message = "OK", response = StaffDetail.class),
        @ApiResponse(code = 400, message = "Invalid request.", response = ErrorResponse.class),
        @ApiResponse(code = 404, message = "Requested resource not found.", response = ErrorResponse.class),
        @ApiResponse(code = 500, message = "Unrecoverable error occurred whilst processing request.", response = ErrorResponse.class) })
    GetStaffDetailResponse getStaffDetail(@ApiParam(value = "The staff id of the staff member.", required = true) @PathParam("staffId") Long staffId);

    @GET
    @Path("/{username}")
    @Consumes({ "application/json" })
    @Produces({ "application/json" })
    @ApiOperation(value = "User detail.", notes = "User detail.", nickname="getUserDetails")
    @ApiResponses(value = {
        @ApiResponse(code = 200, message = "OK", response = UserDetail.class),
        @ApiResponse(code = 400, message = "Invalid request.", response = ErrorResponse.class),
        @ApiResponse(code = 404, message = "Requested resource not found.", response = ErrorResponse.class),
        @ApiResponse(code = 500, message = "Unrecoverable error occurred whilst processing request.", response = ErrorResponse.class) })
    GetUserDetailsResponse getUserDetails(@ApiParam(value = "The username of the user.", required = true) @PathParam("username") String username);

    @GET
    @Path("/{username}/access-roles/caseload/{caseload}")
    @Consumes({ "application/json" })
    @Produces({ "application/json" })
    @ApiOperation(value = "List of roles for the given user and caseload", notes = "List of roles for the given user and caseload", nickname="getRolesForUserAndCaseload")
    @ApiResponses(value = {
        @ApiResponse(code = 200, message = "OK", response = AccessRole.class, responseContainer = "List"),
        @ApiResponse(code = 400, message = "Invalid request.", response = ErrorResponse.class, responseContainer = "List"),
        @ApiResponse(code = 404, message = "Requested resource not found.", response = ErrorResponse.class, responseContainer = "List"),
        @ApiResponse(code = 500, message = "Unrecoverable error occurred whilst processing request.", response = ErrorResponse.class, responseContainer = "List") })
    GetRolesForUserAndCaseloadResponse getRolesForUserAndCaseload(@ApiParam(value = "user account to filter by", required = true) @PathParam("username") String username,
                                                                  @ApiParam(value = "Caseload Id", required = true) @PathParam("caseload") String caseload,
                                                                  @ApiParam(value = "Include admin roles", required = true, defaultValue = "false") @QueryParam("includeAdmin") boolean includeAdmin);

    @PUT
    @Path("/add/default/{caseload}")
    @Consumes({ "application/json" })
    @Produces({ "application/json" })
    @ApiOperation(value = "Add the NWEB caseload to specified caseload.", notes = "Add the NWEB caseload to specified caseload.", nickname="addApiAccessForCaseload")
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = "No New Users", response = CaseloadUpdate.class),
            @ApiResponse(code = 201, message = "New Users Enabled", response = CaseloadUpdate.class),
    })
    AddApiAccessForCaseloadResponse addApiAccessForCaseload(@ApiParam(value = "The caseload (equates to prison) id to add all active users to default API caseload (NWEB)", required = true) @PathParam("caseload") String caseload);

    @PUT
    @Path("/me/activeCaseLoad")
    @Consumes({ "application/json" })
    @Produces({ "application/json" })
    @ApiOperation(value = "Update working caseload for current user.", notes = "Update working caseload for current user.", nickname="updateMyActiveCaseLoad")
    @ApiResponses(value = {
        @ApiResponse(code = 401, message = "Invalid username or password", response = ErrorResponse.class),
        @ApiResponse(code = 403, message = "the user does not have permission to view the caseload.", response = ErrorResponse.class) })
    UpdateMyActiveCaseLoadResponse updateMyActiveCaseLoad(@ApiParam(value = "", required = true) CaseLoad body);

    @PUT
    @Path("/{username}/access-role/{roleCode}")
    @Consumes({ "application/json" })
    @Produces({ "application/json" })
    @ApiOperation(value = "Add the given access role to the user.", notes = "Add the given access role to the user.", nickname="addAccessRole")
    @ApiResponses(value = {
        @ApiResponse(code = 200, message = ""),
        @ApiResponse(code = 201, message = "") })
    AddAccessRoleResponse addAccessRole(@ApiParam(value = "The username of the user.", required = true) @PathParam("username") String username,
                                        @ApiParam(value = "access role code", required = true) @PathParam("roleCode") String roleCode);

    @PUT
    @Path("/{username}/caseload/{caseload}/access-role/{roleCode}")
    @Consumes({ "application/json" })
    @Produces({ "application/json" })
    @ApiOperation(value = "Add the given access role to the user and caseload.", notes = "Add the given access role to the user and caseload.", nickname="addAccessRoleByCaseload")
    @ApiResponses(value = {
        @ApiResponse(code = 200, message = ""),
        @ApiResponse(code = 201, message = "") })
    AddAccessRoleByCaseloadResponse addAccessRoleByCaseload(@ApiParam(value = "The username of the user.", required = true) @PathParam("username") String username,
                                                            @ApiParam(value = "Caseload Id", required = true) @PathParam("caseload") String caseload,
                                                            @ApiParam(value = "access role code", required = true) @PathParam("roleCode") String roleCode);

    class RemoveUsersAccessRoleForCaseloadResponse extends ResponseDelegate {

        private RemoveUsersAccessRoleForCaseloadResponse(Response response) { super(response); }
        private RemoveUsersAccessRoleForCaseloadResponse(Response response, Object entity) { super(response, entity); }

        public static RemoveUsersAccessRoleForCaseloadResponse respond200WithApplicationJson() {
            ResponseBuilder responseBuilder = Response.status(200)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            return new RemoveUsersAccessRoleForCaseloadResponse(responseBuilder.build());
        }

        public static RemoveUsersAccessRoleForCaseloadResponse respond404WithApplicationJson() {
            ResponseBuilder responseBuilder = Response.status(404)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            return new RemoveUsersAccessRoleForCaseloadResponse(responseBuilder.build());
        }
    }

    class GetUsersResponse extends ResponseDelegate {

        private GetUsersResponse(Response response) { super(response); }
        private GetUsersResponse(Response response, Object entity) { super(response, entity); }

        public static GetUsersResponse respond200WithApplicationJson(Page<UserDetail> page) {
            ResponseBuilder responseBuilder = Response.status(200)
                    .header("Content-Type", MediaType.APPLICATION_JSON)
                    .header("Total-Records", page.getTotalRecords())
                    .header("Page-Offset", page.getPageOffset())
                    .header("Page-Limit", page.getPageLimit());
            responseBuilder.entity(page.getItems());
            return new GetUsersResponse(responseBuilder.build(), page.getItems());
        }

        public static GetUsersResponse respond400WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(400)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetUsersResponse(responseBuilder.build(), entity);
        }

        public static GetUsersResponse respond404WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(404)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetUsersResponse(responseBuilder.build(), entity);
        }

        public static GetUsersResponse respond500WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(500)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetUsersResponse(responseBuilder.build(), entity);
        }
    }

    class GetAllUsersHavingRoleAtCaseloadResponse extends ResponseDelegate {

        private GetAllUsersHavingRoleAtCaseloadResponse(Response response) { super(response); }
        private GetAllUsersHavingRoleAtCaseloadResponse(Response response, Object entity) { super(response, entity); }

        public static GetAllUsersHavingRoleAtCaseloadResponse respond200WithApplicationJson(List<String> entity) {
            ResponseBuilder responseBuilder = Response.status(200)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetAllUsersHavingRoleAtCaseloadResponse(responseBuilder.build(), entity);
        }

        public static GetAllUsersHavingRoleAtCaseloadResponse respond400WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(400)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetAllUsersHavingRoleAtCaseloadResponse(responseBuilder.build(), entity);
        }

        public static GetAllUsersHavingRoleAtCaseloadResponse respond404WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(404)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetAllUsersHavingRoleAtCaseloadResponse(responseBuilder.build(), entity);
        }

        public static GetAllUsersHavingRoleAtCaseloadResponse respond500WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(500)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetAllUsersHavingRoleAtCaseloadResponse(responseBuilder.build(), entity);
        }
    }

    class GetUsersByCaseLoadResponse extends ResponseDelegate {

        private GetUsersByCaseLoadResponse(Response response) { super(response); }
        private GetUsersByCaseLoadResponse(Response response, Object entity) { super(response, entity); }

        public static GetUsersByCaseLoadResponse respond200WithApplicationJson(Page<UserDetail> page) {
            ResponseBuilder responseBuilder = Response.status(200)
                    .header("Content-Type", MediaType.APPLICATION_JSON)
                    .header("Total-Records", page.getTotalRecords())
                    .header("Page-Offset", page.getPageOffset())
                    .header("Page-Limit", page.getPageLimit());
            responseBuilder.entity(page.getItems());
            return new GetUsersByCaseLoadResponse(responseBuilder.build(), page.getItems());
        }

        public static GetUsersByCaseLoadResponse respond400WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(400)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetUsersByCaseLoadResponse(responseBuilder.build(), entity);
        }

        public static GetUsersByCaseLoadResponse respond404WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(404)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetUsersByCaseLoadResponse(responseBuilder.build(), entity);
        }

        public static GetUsersByCaseLoadResponse respond500WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(500)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetUsersByCaseLoadResponse(responseBuilder.build(), entity);
        }
    }

    class GetLocalAdministratorUsersByCaseLoadResponse extends ResponseDelegate {

        private GetLocalAdministratorUsersByCaseLoadResponse(Response response) { super(response); }
        private GetLocalAdministratorUsersByCaseLoadResponse(Response response, Object entity) { super(response, entity); }

        public static GetLocalAdministratorUsersByCaseLoadResponse respond200WithApplicationJson(Page<UserDetail> page) {
            ResponseBuilder responseBuilder = Response.status(200)
                    .header("Content-Type", MediaType.APPLICATION_JSON)
                    .header("Total-Records", page.getTotalRecords())
                    .header("Page-Offset", page.getPageOffset())
                    .header("Page-Limit", page.getPageLimit());
            responseBuilder.entity(page.getItems());
            return new GetLocalAdministratorUsersByCaseLoadResponse(responseBuilder.build(), page.getItems());
        }

        public static GetLocalAdministratorUsersByCaseLoadResponse respond400WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(400)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetLocalAdministratorUsersByCaseLoadResponse(responseBuilder.build(), entity);
        }

        public static GetLocalAdministratorUsersByCaseLoadResponse respond404WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(404)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetLocalAdministratorUsersByCaseLoadResponse(responseBuilder.build(), entity);
        }

        public static GetLocalAdministratorUsersByCaseLoadResponse respond500WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(500)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetLocalAdministratorUsersByCaseLoadResponse(responseBuilder.build(), entity);
        }
    }

    class GetMyUserInformationResponse extends ResponseDelegate {

        private GetMyUserInformationResponse(Response response) { super(response); }
        private GetMyUserInformationResponse(Response response, Object entity) { super(response, entity); }

        public static GetMyUserInformationResponse respond200WithApplicationJson(UserDetail entity) {
            ResponseBuilder responseBuilder = Response.status(200)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetMyUserInformationResponse(responseBuilder.build(), entity);
        }

        public static GetMyUserInformationResponse respond400WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(400)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetMyUserInformationResponse(responseBuilder.build(), entity);
        }

        public static GetMyUserInformationResponse respond404WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(404)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetMyUserInformationResponse(responseBuilder.build(), entity);
        }

        public static GetMyUserInformationResponse respond500WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(500)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetMyUserInformationResponse(responseBuilder.build(), entity);
        }
    }

    class GetMyAssignmentsResponse extends ResponseDelegate {

        private GetMyAssignmentsResponse(Response response) { super(response); }
        private GetMyAssignmentsResponse(Response response, Object entity) { super(response, entity); }

        public static GetMyAssignmentsResponse respond200WithApplicationJson(Page<OffenderBooking> page) {
            ResponseBuilder responseBuilder = Response.status(200)
                    .header("Content-Type", MediaType.APPLICATION_JSON)
                    .header("Total-Records", page.getTotalRecords())
                    .header("Page-Offset", page.getPageOffset())
                    .header("Page-Limit", page.getPageLimit());
            responseBuilder.entity(page.getItems());
            return new GetMyAssignmentsResponse(responseBuilder.build(), page.getItems());
        }

        public static GetMyAssignmentsResponse respond400WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(400)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetMyAssignmentsResponse(responseBuilder.build(), entity);
        }

        public static GetMyAssignmentsResponse respond404WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(404)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetMyAssignmentsResponse(responseBuilder.build(), entity);
        }

        public static GetMyAssignmentsResponse respond500WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(500)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetMyAssignmentsResponse(responseBuilder.build(), entity);
        }
    }

    class GetMyCaseLoadsResponse extends ResponseDelegate {

        private GetMyCaseLoadsResponse(Response response) { super(response); }
        private GetMyCaseLoadsResponse(Response response, Object entity) { super(response, entity); }

        public static GetMyCaseLoadsResponse respond200WithApplicationJson(List<CaseLoad> entity) {
            ResponseBuilder responseBuilder = Response.status(200)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetMyCaseLoadsResponse(responseBuilder.build(), entity);
        }

        public static GetMyCaseLoadsResponse respond400WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(400)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetMyCaseLoadsResponse(responseBuilder.build(), entity);
        }

        public static GetMyCaseLoadsResponse respond404WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(404)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetMyCaseLoadsResponse(responseBuilder.build(), entity);
        }

        public static GetMyCaseLoadsResponse respond500WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(500)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetMyCaseLoadsResponse(responseBuilder.build(), entity);
        }
    }

    class GetMyCaseNoteTypesResponse extends ResponseDelegate {

        private GetMyCaseNoteTypesResponse(Response response) { super(response); }
        private GetMyCaseNoteTypesResponse(Response response, Object entity) { super(response, entity); }

        public static GetMyCaseNoteTypesResponse respond200WithApplicationJson(List<ReferenceCode> entity) {
            ResponseBuilder responseBuilder = Response.status(200)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetMyCaseNoteTypesResponse(responseBuilder.build(), entity);
        }

        public static GetMyCaseNoteTypesResponse respond400WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(400)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetMyCaseNoteTypesResponse(responseBuilder.build(), entity);
        }

        public static GetMyCaseNoteTypesResponse respond404WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(404)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetMyCaseNoteTypesResponse(responseBuilder.build(), entity);
        }

        public static GetMyCaseNoteTypesResponse respond500WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(500)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetMyCaseNoteTypesResponse(responseBuilder.build(), entity);
        }
    }

    class GetMyLocationsResponse extends ResponseDelegate {

        private GetMyLocationsResponse(Response response) { super(response); }
        private GetMyLocationsResponse(Response response, Object entity) { super(response, entity); }

        public static GetMyLocationsResponse respond200WithApplicationJson(List<Location> entity) {
            ResponseBuilder responseBuilder = Response.status(200)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetMyLocationsResponse(responseBuilder.build(), entity);
        }

        public static GetMyLocationsResponse respond400WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(400)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetMyLocationsResponse(responseBuilder.build(), entity);
        }

        public static GetMyLocationsResponse respond404WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(404)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetMyLocationsResponse(responseBuilder.build(), entity);
        }

        public static GetMyLocationsResponse respond500WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(500)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetMyLocationsResponse(responseBuilder.build(), entity);
        }
    }

    class GetMyRolesResponse extends ResponseDelegate {

        private GetMyRolesResponse(Response response) { super(response); }
        private GetMyRolesResponse(Response response, Object entity) { super(response, entity); }

        public static GetMyRolesResponse respond200WithApplicationJson(List<UserRole> entity) {
            ResponseBuilder responseBuilder = Response.status(200)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetMyRolesResponse(responseBuilder.build(), entity);
        }

        public static GetMyRolesResponse respond400WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(400)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetMyRolesResponse(responseBuilder.build(), entity);
        }

        public static GetMyRolesResponse respond404WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(404)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetMyRolesResponse(responseBuilder.build(), entity);
        }

        public static GetMyRolesResponse respond500WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(500)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetMyRolesResponse(responseBuilder.build(), entity);
        }
    }

    class GetStaffDetailResponse extends ResponseDelegate {

        private GetStaffDetailResponse(Response response) { super(response); }
        private GetStaffDetailResponse(Response response, Object entity) { super(response, entity); }

        public static GetStaffDetailResponse respond200WithApplicationJson(StaffDetail entity) {
            ResponseBuilder responseBuilder = Response.status(200)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetStaffDetailResponse(responseBuilder.build(), entity);
        }

        public static GetStaffDetailResponse respond400WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(400)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetStaffDetailResponse(responseBuilder.build(), entity);
        }

        public static GetStaffDetailResponse respond404WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(404)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetStaffDetailResponse(responseBuilder.build(), entity);
        }

        public static GetStaffDetailResponse respond500WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(500)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetStaffDetailResponse(responseBuilder.build(), entity);
        }
    }

    class GetUserDetailsResponse extends ResponseDelegate {

        private GetUserDetailsResponse(Response response) { super(response); }
        private GetUserDetailsResponse(Response response, Object entity) { super(response, entity); }

        public static GetUserDetailsResponse respond200WithApplicationJson(UserDetail entity) {
            ResponseBuilder responseBuilder = Response.status(200)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetUserDetailsResponse(responseBuilder.build(), entity);
        }

        public static GetUserDetailsResponse respond400WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(400)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetUserDetailsResponse(responseBuilder.build(), entity);
        }

        public static GetUserDetailsResponse respond404WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(404)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetUserDetailsResponse(responseBuilder.build(), entity);
        }

        public static GetUserDetailsResponse respond500WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(500)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetUserDetailsResponse(responseBuilder.build(), entity);
        }
    }

    class GetRolesForUserAndCaseloadResponse extends ResponseDelegate {

        private GetRolesForUserAndCaseloadResponse(Response response) { super(response); }
        private GetRolesForUserAndCaseloadResponse(Response response, Object entity) { super(response, entity); }

        public static GetRolesForUserAndCaseloadResponse respond200WithApplicationJson(List<AccessRole> entity) {
            ResponseBuilder responseBuilder = Response.status(200)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetRolesForUserAndCaseloadResponse(responseBuilder.build(), entity);
        }

        public static GetRolesForUserAndCaseloadResponse respond400WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(400)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetRolesForUserAndCaseloadResponse(responseBuilder.build(), entity);
        }

        public static GetRolesForUserAndCaseloadResponse respond404WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(404)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetRolesForUserAndCaseloadResponse(responseBuilder.build(), entity);
        }

        public static GetRolesForUserAndCaseloadResponse respond500WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(500)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetRolesForUserAndCaseloadResponse(responseBuilder.build(), entity);
        }
    }

    class AddApiAccessForCaseloadResponse extends ResponseDelegate {

        private AddApiAccessForCaseloadResponse(Response response) { super(response); }
        private AddApiAccessForCaseloadResponse(Response response, Object entity) { super(response, entity); }

        public static AddApiAccessForCaseloadResponse respond200WithApplicationJson(CaseloadUpdate caseloadUpdate) {
            ResponseBuilder responseBuilder = Response.status(200)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(caseloadUpdate);
            return new AddApiAccessForCaseloadResponse(responseBuilder.build(), caseloadUpdate);
        }

        public static AddApiAccessForCaseloadResponse respond201WithApplicationJson(CaseloadUpdate caseloadUpdate) {
            ResponseBuilder responseBuilder = Response.status(201)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(caseloadUpdate);
            return new AddApiAccessForCaseloadResponse(responseBuilder.build(), caseloadUpdate);
        }
    }

    class UpdateMyActiveCaseLoadResponse extends ResponseDelegate {

        private UpdateMyActiveCaseLoadResponse(Response response) { super(response); }
        private UpdateMyActiveCaseLoadResponse(Response response, Object entity) { super(response, entity); }

        public static UpdateMyActiveCaseLoadResponse respond401WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(401)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new UpdateMyActiveCaseLoadResponse(responseBuilder.build(), entity);
        }

        public static UpdateMyActiveCaseLoadResponse respond403WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(403)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new UpdateMyActiveCaseLoadResponse(responseBuilder.build(), entity);
        }
    }

    class AddAccessRoleResponse extends ResponseDelegate {

        private AddAccessRoleResponse(Response response) { super(response); }
        private AddAccessRoleResponse(Response response, Object entity) { super(response, entity); }

        public static AddAccessRoleResponse respond200WithApplicationJson() {
            ResponseBuilder responseBuilder = Response.status(200)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            return new AddAccessRoleResponse(responseBuilder.build());
        }

        public static AddAccessRoleResponse respond201WithApplicationJson() {
            ResponseBuilder responseBuilder = Response.status(201)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            return new AddAccessRoleResponse(responseBuilder.build());
        }
    }

    class AddAccessRoleByCaseloadResponse extends ResponseDelegate {

        private AddAccessRoleByCaseloadResponse(Response response) { super(response); }
        private AddAccessRoleByCaseloadResponse(Response response, Object entity) { super(response, entity); }

        public static AddAccessRoleByCaseloadResponse respond200WithApplicationJson() {
            ResponseBuilder responseBuilder = Response.status(200)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            return new AddAccessRoleByCaseloadResponse(responseBuilder.build());
        }

        public static AddAccessRoleByCaseloadResponse respond201WithApplicationJson() {
            ResponseBuilder responseBuilder = Response.status(201)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            return new AddAccessRoleByCaseloadResponse(responseBuilder.build());
        }
    }
}