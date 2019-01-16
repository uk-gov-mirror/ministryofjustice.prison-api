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

@Api(tags = {"/staff"})
@SuppressWarnings("unused")
public interface StaffResource {

    @DELETE
    @Path("/{staffId}/access-roles/caseload/{caseload}/access-role/{roleCode}")
    @Consumes({ "application/json" })
    @Produces({ "application/json" })
    @ApiOperation(value = "remove access roles from user and specific caseload", notes = "remove access roles from user and specific caseload", nickname="removeStaffAccessRole")
    @ApiResponses(value = { 
        @ApiResponse(code = 200, message = "The access role has been removed", response = String.class) })
    RemoveStaffAccessRoleResponse removeStaffAccessRole(@ApiParam(value = "The staff id of the staff member.", required = true) @PathParam("staffId") Long staffId,
                                                        @ApiParam(value = "Caseload Id", required = true) @PathParam("caseload") String caseload,
                                                        @ApiParam(value = "access role code", required = true) @PathParam("roleCode") String roleCode);

    @GET
    @Path("/access-roles/caseload/{caseload}/access-role/{roleCode}")
    @Consumes({ "application/json" })
    @Produces({ "application/json" })
    @ApiOperation(value = "List access roles for staff by type and caseload", notes = "List access roles for staff by type and caseload", nickname="getAllStaffAccessRolesForCaseload")
    @ApiResponses(value = {
        @ApiResponse(code = 200, message = "OK", response = StaffUserRole.class, responseContainer = "List"),
        @ApiResponse(code = 400, message = "Invalid request.", response = ErrorResponse.class, responseContainer = "List"),
        @ApiResponse(code = 404, message = "Requested resource not found.", response = ErrorResponse.class, responseContainer = "List"),
        @ApiResponse(code = 500, message = "Unrecoverable error occurred whilst processing request.", response = ErrorResponse.class, responseContainer = "List") })
    GetAllStaffAccessRolesForCaseloadResponse getAllStaffAccessRolesForCaseload(@ApiParam(value = "Caseload Id", required = true) @PathParam("caseload") String caseload,
                                                                                @ApiParam(value = "access role code", required = true) @PathParam("roleCode") String roleCode);

    @GET
    @Path("/roles/{agencyId}/position/{position}/role/{role}")
    @Consumes({ "application/json" })
    @Produces({ "application/json" })
    @ApiOperation(value = "Get staff members within agency who are currently assigned the specified position and/or role.", notes = "Get staff members within agency who are currently assigned the specified position and/or role.", nickname="getStaffByAgencyPositionRole")
    @ApiResponses(value = {
        @ApiResponse(code = 200, message = "OK", response = StaffLocationRole.class, responseContainer = "List"),
        @ApiResponse(code = 400, message = "Invalid request.", response = ErrorResponse.class, responseContainer = "List"),
        @ApiResponse(code = 404, message = "Requested resource not found.", response = ErrorResponse.class, responseContainer = "List"),
        @ApiResponse(code = 500, message = "Unrecoverable error occurred whilst processing request.", response = ErrorResponse.class, responseContainer = "List") })
    GetStaffByAgencyPositionRoleResponse getStaffByAgencyPositionRole(@ApiParam(value = "The agency (prison) id.", required = true) @PathParam("agencyId") String agencyId,
                                                                      @ApiParam(value = "The staff position.", required = true) @PathParam("position") String position,
                                                                      @ApiParam(value = "The staff role.", required = true) @PathParam("role") String role,
                                                                      @ApiParam(value = "Filter results by first name and/or last name of staff member.") @QueryParam("nameFilter") String nameFilter,
                                                                      @ApiParam(value = "The staff id of a staff member.") @QueryParam("staffId") Long staffId,
                                                                      @ApiParam(value = "Filters results by activeOnly staff members.", defaultValue = "true") @QueryParam("activeOnly") Boolean activeOnly,
                                                                      @ApiParam(value = "Requested offset of first record in returned collection of role records.", defaultValue = "0") @HeaderParam("Page-Offset") Long pageOffset,
                                                                      @ApiParam(value = "Requested limit to number of role records returned.", defaultValue = "10") @HeaderParam("Page-Limit") Long pageLimit,
                                                                      @ApiParam(value = "Comma separated list of one or more of the following fields - <b>firstName, lastName</b>") @HeaderParam("Sort-Fields") String sortFields,
                                                                      @ApiParam(value = "Sort order (ASC or DESC) - defaults to ASC.", defaultValue = "ASC") @HeaderParam("Sort-Order") Order sortOrder);

    @GET
    @Path("/roles/{agencyId}/role/{role}")
    @Consumes({ "application/json" })
    @Produces({ "application/json" })
    @ApiOperation(value = "Get staff members within agency who are currently assigned the specified role.", notes = "Get staff members within agency who are currently assigned the specified role.", nickname="getStaffByAgencyRole")
    @ApiResponses(value = {
        @ApiResponse(code = 200, message = "OK", response = StaffLocationRole.class, responseContainer = "List"),
        @ApiResponse(code = 400, message = "Invalid request.", response = ErrorResponse.class, responseContainer = "List"),
        @ApiResponse(code = 404, message = "Requested resource not found.", response = ErrorResponse.class, responseContainer = "List"),
        @ApiResponse(code = 500, message = "Unrecoverable error occurred whilst processing request.", response = ErrorResponse.class, responseContainer = "List") })
    GetStaffByAgencyRoleResponse getStaffByAgencyRole(@ApiParam(value = "The agency (prison) id.", required = true) @PathParam("agencyId") String agencyId,
                                                      @ApiParam(value = "The staff role.", required = true) @PathParam("role") String role,
                                                      @ApiParam(value = "Filter results by first name and/or last name of staff member. Supplied filter term is matched to start of staff member's first and last name.") @QueryParam("nameFilter") String nameFilter,
                                                      @ApiParam(value = "The staff id of a staff member.") @QueryParam("staffId") Long staffId,
                                                      @ApiParam(value = "Filters results by activeOnly staff members.", defaultValue = "true") @QueryParam("activeOnly") Boolean activeOnly,
                                                      @ApiParam(value = "Requested offset of first record in returned collection of role records.", defaultValue = "0") @HeaderParam("Page-Offset") Long pageOffset,
                                                      @ApiParam(value = "Requested limit to number of role records returned.", defaultValue = "10") @HeaderParam("Page-Limit") Long pageLimit,
                                                      @ApiParam(value = "Comma separated list of one or more of the following fields - <b>firstName, lastName</b>") @HeaderParam("Sort-Fields") String sortFields,
                                                      @ApiParam(value = "Sort order (ASC or DESC) - defaults to ASC.", defaultValue = "ASC") @HeaderParam("Sort-Order") Order sortOrder);

    @GET
    @Path("/{staffId}")
    @Consumes({ "application/json" })
    @Produces({ "application/json" })
    @ApiOperation(value = "Staff detail.", notes = "Staff detail.", nickname="getStaffDetail")
    @ApiResponses(value = {
        @ApiResponse(code = 200, message = "OK", response = StaffDetail.class),
        @ApiResponse(code = 400, message = "Invalid request.", response = ErrorResponse.class),
        @ApiResponse(code = 404, message = "Requested resource not found.", response = ErrorResponse.class),
        @ApiResponse(code = 500, message = "Unrecoverable error occurred whilst processing request.", response = ErrorResponse.class) })
    GetStaffDetailResponse getStaffDetail(@ApiParam(value = "The staff id of the staff member.", required = true) @PathParam("staffId") Long staffId);

    @GET
    @Path("/{staffId}/access-roles")
    @Consumes({ "application/json" })
    @Produces({ "application/json" })
    @ApiOperation(value = "List of access roles for specified staff user and caseload", notes = "List of access roles for specified staff user and caseload", nickname="getStaffAccessRoles")
    @ApiResponses(value = {
        @ApiResponse(code = 200, message = "OK", response = StaffUserRole.class, responseContainer = "List"),
        @ApiResponse(code = 400, message = "Invalid request.", response = ErrorResponse.class, responseContainer = "List"),
        @ApiResponse(code = 404, message = "Requested resource not found.", response = ErrorResponse.class, responseContainer = "List"),
        @ApiResponse(code = 500, message = "Unrecoverable error occurred whilst processing request.", response = ErrorResponse.class, responseContainer = "List") })
    GetStaffAccessRolesResponse getStaffAccessRoles(@ApiParam(value = "The staff id of the staff user.", required = true) @PathParam("staffId") Long staffId);

    @GET
    @Path("/{staffId}/access-roles/caseload/{caseload}")
    @Consumes({ "application/json" })
    @Produces({ "application/json" })
    @ApiOperation(value = "List of access roles for specified staff user and caseload", notes = "List of access roles for specified staff user and caseload", nickname="getAccessRolesByCaseload")
    @ApiResponses(value = {
        @ApiResponse(code = 200, message = "OK", response = StaffUserRole.class, responseContainer = "List"),
        @ApiResponse(code = 400, message = "Invalid request.", response = ErrorResponse.class, responseContainer = "List"),
        @ApiResponse(code = 404, message = "Requested resource not found.", response = ErrorResponse.class, responseContainer = "List"),
        @ApiResponse(code = 500, message = "Unrecoverable error occurred whilst processing request.", response = ErrorResponse.class, responseContainer = "List") })
    GetAccessRolesByCaseloadResponse getAccessRolesByCaseload(@ApiParam(value = "The staff id of the staff member.", required = true) @PathParam("staffId") Long staffId,
                                                              @ApiParam(value = "Caseload Id", required = true) @PathParam("caseload") String caseload);

    @GET
    @Path("/{staffId}/{agencyId}/roles")
    @Consumes({ "application/json" })
    @Produces({ "application/json" })
    @ApiOperation(value = "List of job roles for specified staff and agency Id", notes = "List of job roles for specified staff and agency Id", nickname="getAllRolesForAgency")
    @ApiResponses(value = {
        @ApiResponse(code = 200, message = "OK", response = StaffRole.class, responseContainer = "List"),
        @ApiResponse(code = 400, message = "Invalid request.", response = ErrorResponse.class, responseContainer = "List"),
        @ApiResponse(code = 404, message = "Requested resource not found.", response = ErrorResponse.class, responseContainer = "List"),
        @ApiResponse(code = 500, message = "Unrecoverable error occurred whilst processing request.", response = ErrorResponse.class, responseContainer = "List") })
    GetAllRolesForAgencyResponse getAllRolesForAgency(@ApiParam(value = "The staff id of the staff member.", required = true) @PathParam("staffId") Long staffId,
                                                      @ApiParam(value = "Agency Id.", required = true) @PathParam("agencyId") String agencyId);

    @POST
    @Path("/{staffId}/access-roles")
    @Consumes({ "application/json" })
    @Produces({ "application/json" })
    @ApiOperation(value = "add access role to staff user for API caseload", notes = "add access role to staff user for API caseload", nickname="addStaffAccessRoleForApiCaseload")
    @ApiResponses(value = {
        @ApiResponse(code = 201, message = "The access role has been created.", response = StaffUserRole.class) })
    AddStaffAccessRoleForApiCaseloadResponse addStaffAccessRoleForApiCaseload(@ApiParam(value = "The staff id of the staff user.", required = true) @PathParam("staffId") Long staffId,
                                                                              @ApiParam(value = "new access role code required", required = true) String body);

    @POST
    @Path("/{staffId}/access-roles/caseload/{caseload}")
    @Consumes({ "application/json" })
    @Produces({ "application/json" })
    @ApiOperation(value = "add access role to staff user", notes = "add access role to staff user", nickname="addStaffAccessRole")
    @ApiResponses(value = {
        @ApiResponse(code = 201, message = "The access role has been created.", response = StaffUserRole.class) })
    AddStaffAccessRoleResponse addStaffAccessRole(@ApiParam(value = "The staff id of the staff member.", required = true) @PathParam("staffId") Long staffId,
                                                  @ApiParam(value = "Caseload Id", required = true) @PathParam("caseload") String caseload,
                                                  @ApiParam(value = "new access role code required", required = true) String body);

    class RemoveStaffAccessRoleResponse extends ResponseDelegate {

        private RemoveStaffAccessRoleResponse(Response response) { super(response); }
        private RemoveStaffAccessRoleResponse(Response response, Object entity) { super(response, entity); }

        public static RemoveStaffAccessRoleResponse respond200WithApplicationJson(String entity) {
            ResponseBuilder responseBuilder = Response.status(200)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new RemoveStaffAccessRoleResponse(responseBuilder.build(), entity);
        }
    }

    class GetAllStaffAccessRolesForCaseloadResponse extends ResponseDelegate {

        private GetAllStaffAccessRolesForCaseloadResponse(Response response) { super(response); }
        private GetAllStaffAccessRolesForCaseloadResponse(Response response, Object entity) { super(response, entity); }

        public static GetAllStaffAccessRolesForCaseloadResponse respond200WithApplicationJson(List<StaffUserRole> entity) {
            ResponseBuilder responseBuilder = Response.status(200)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetAllStaffAccessRolesForCaseloadResponse(responseBuilder.build(), entity);
        }

        public static GetAllStaffAccessRolesForCaseloadResponse respond400WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(400)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetAllStaffAccessRolesForCaseloadResponse(responseBuilder.build(), entity);
        }

        public static GetAllStaffAccessRolesForCaseloadResponse respond404WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(404)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetAllStaffAccessRolesForCaseloadResponse(responseBuilder.build(), entity);
        }

        public static GetAllStaffAccessRolesForCaseloadResponse respond500WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(500)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetAllStaffAccessRolesForCaseloadResponse(responseBuilder.build(), entity);
        }
    }

    class GetStaffByAgencyPositionRoleResponse extends ResponseDelegate {

        private GetStaffByAgencyPositionRoleResponse(Response response) { super(response); }
        private GetStaffByAgencyPositionRoleResponse(Response response, Object entity) { super(response, entity); }

        public static GetStaffByAgencyPositionRoleResponse respond200WithApplicationJson(Page<StaffLocationRole> page) {
            ResponseBuilder responseBuilder = Response.status(200)
                    .header("Content-Type", MediaType.APPLICATION_JSON)
                    .header("Total-Records", page.getTotalRecords())
                    .header("Page-Offset", page.getPageOffset())
                    .header("Page-Limit", page.getPageLimit());
            responseBuilder.entity(page.getItems());
            return new GetStaffByAgencyPositionRoleResponse(responseBuilder.build(), page.getItems());
        }

        public static GetStaffByAgencyPositionRoleResponse respond400WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(400)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetStaffByAgencyPositionRoleResponse(responseBuilder.build(), entity);
        }

        public static GetStaffByAgencyPositionRoleResponse respond404WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(404)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetStaffByAgencyPositionRoleResponse(responseBuilder.build(), entity);
        }

        public static GetStaffByAgencyPositionRoleResponse respond500WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(500)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetStaffByAgencyPositionRoleResponse(responseBuilder.build(), entity);
        }
    }

    class GetStaffByAgencyRoleResponse extends ResponseDelegate {

        private GetStaffByAgencyRoleResponse(Response response) { super(response); }
        private GetStaffByAgencyRoleResponse(Response response, Object entity) { super(response, entity); }

        public static GetStaffByAgencyRoleResponse respond200WithApplicationJson(Page<StaffLocationRole> page) {
            ResponseBuilder responseBuilder = Response.status(200)
                    .header("Content-Type", MediaType.APPLICATION_JSON)
                    .header("Total-Records", page.getTotalRecords())
                    .header("Page-Offset", page.getPageOffset())
                    .header("Page-Limit", page.getPageLimit());
            responseBuilder.entity(page.getItems());
            return new GetStaffByAgencyRoleResponse(responseBuilder.build(), page.getItems());
        }

        public static GetStaffByAgencyRoleResponse respond400WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(400)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetStaffByAgencyRoleResponse(responseBuilder.build(), entity);
        }

        public static GetStaffByAgencyRoleResponse respond404WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(404)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetStaffByAgencyRoleResponse(responseBuilder.build(), entity);
        }

        public static GetStaffByAgencyRoleResponse respond500WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(500)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetStaffByAgencyRoleResponse(responseBuilder.build(), entity);
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

    class GetStaffAccessRolesResponse extends ResponseDelegate {

        private GetStaffAccessRolesResponse(Response response) { super(response); }
        private GetStaffAccessRolesResponse(Response response, Object entity) { super(response, entity); }

        public static GetStaffAccessRolesResponse respond200WithApplicationJson(List<StaffUserRole> entity) {
            ResponseBuilder responseBuilder = Response.status(200)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetStaffAccessRolesResponse(responseBuilder.build(), entity);
        }

        public static GetStaffAccessRolesResponse respond400WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(400)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetStaffAccessRolesResponse(responseBuilder.build(), entity);
        }

        public static GetStaffAccessRolesResponse respond404WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(404)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetStaffAccessRolesResponse(responseBuilder.build(), entity);
        }

        public static GetStaffAccessRolesResponse respond500WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(500)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetStaffAccessRolesResponse(responseBuilder.build(), entity);
        }
    }

    class GetAccessRolesByCaseloadResponse extends ResponseDelegate {

        private GetAccessRolesByCaseloadResponse(Response response) { super(response); }
        private GetAccessRolesByCaseloadResponse(Response response, Object entity) { super(response, entity); }

        public static GetAccessRolesByCaseloadResponse respond200WithApplicationJson(List<StaffUserRole> entity) {
            ResponseBuilder responseBuilder = Response.status(200)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetAccessRolesByCaseloadResponse(responseBuilder.build(), entity);
        }

        public static GetAccessRolesByCaseloadResponse respond400WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(400)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetAccessRolesByCaseloadResponse(responseBuilder.build(), entity);
        }

        public static GetAccessRolesByCaseloadResponse respond404WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(404)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetAccessRolesByCaseloadResponse(responseBuilder.build(), entity);
        }

        public static GetAccessRolesByCaseloadResponse respond500WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(500)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetAccessRolesByCaseloadResponse(responseBuilder.build(), entity);
        }
    }

    class GetAllRolesForAgencyResponse extends ResponseDelegate {

        private GetAllRolesForAgencyResponse(Response response) { super(response); }
        private GetAllRolesForAgencyResponse(Response response, Object entity) { super(response, entity); }

        public static GetAllRolesForAgencyResponse respond200WithApplicationJson(List<StaffRole> entity) {
            ResponseBuilder responseBuilder = Response.status(200)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetAllRolesForAgencyResponse(responseBuilder.build(), entity);
        }

        public static GetAllRolesForAgencyResponse respond400WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(400)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetAllRolesForAgencyResponse(responseBuilder.build(), entity);
        }

        public static GetAllRolesForAgencyResponse respond404WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(404)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetAllRolesForAgencyResponse(responseBuilder.build(), entity);
        }

        public static GetAllRolesForAgencyResponse respond500WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(500)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetAllRolesForAgencyResponse(responseBuilder.build(), entity);
        }
    }

    class AddStaffAccessRoleForApiCaseloadResponse extends ResponseDelegate {

        private AddStaffAccessRoleForApiCaseloadResponse(Response response) { super(response); }
        private AddStaffAccessRoleForApiCaseloadResponse(Response response, Object entity) { super(response, entity); }

        public static AddStaffAccessRoleForApiCaseloadResponse respond201WithApplicationJson(StaffUserRole entity) {
            ResponseBuilder responseBuilder = Response.status(201)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new AddStaffAccessRoleForApiCaseloadResponse(responseBuilder.build(), entity);
        }
    }

    class AddStaffAccessRoleResponse extends ResponseDelegate {

        private AddStaffAccessRoleResponse(Response response) { super(response); }
        private AddStaffAccessRoleResponse(Response response, Object entity) { super(response, entity); }

        public static AddStaffAccessRoleResponse respond201WithApplicationJson(StaffUserRole entity) {
            ResponseBuilder responseBuilder = Response.status(201)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new AddStaffAccessRoleResponse(responseBuilder.build(), entity);
        }
    }
}