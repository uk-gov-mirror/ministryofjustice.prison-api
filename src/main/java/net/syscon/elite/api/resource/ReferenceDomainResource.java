package net.syscon.elite.api.resource;

import io.swagger.annotations.*;
import net.syscon.elite.api.model.ErrorResponse;
import net.syscon.elite.api.model.ReferenceCode;
import net.syscon.elite.api.support.Order;
import net.syscon.elite.api.support.Page;
import net.syscon.elite.api.support.ResponseDelegate;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.List;

@Api(tags = {"/reference-domains"})
@SuppressWarnings("unused")
public interface ReferenceDomainResource {

    @GET
    @Path("/alertTypes")
    @Consumes({ "application/json" })
    @Produces({ "application/json" })
    @ApiOperation(value = "List of alert types (with alert codes).", notes = "List of alert types (with alert codes).", nickname="getAlertTypes")
    @ApiResponses(value = { 
        @ApiResponse(code = 200, message = "OK", response = ReferenceCode.class, responseContainer = "List"),
        @ApiResponse(code = 400, message = "Invalid request.", response = ErrorResponse.class, responseContainer = "List"),
        @ApiResponse(code = 404, message = "Requested resource not found.", response = ErrorResponse.class, responseContainer = "List"),
        @ApiResponse(code = 500, message = "Unrecoverable error occurred whilst processing request.", response = ErrorResponse.class, responseContainer = "List") })
    GetAlertTypesResponse getAlertTypes(@ApiParam(value = "Requested offset of first record in returned collection of alertType records.", defaultValue = "0") @HeaderParam("Page-Offset") Long pageOffset,
                                        @ApiParam(value = "Requested limit to number of alertType records returned.", defaultValue = "10") @HeaderParam("Page-Limit") Long pageLimit,
                                        @ApiParam(value = "Comma separated list of one or more of the following fields - <b>code, description</b>") @HeaderParam("Sort-Fields") String sortFields,
                                        @ApiParam(value = "Sort order (ASC or DESC) - defaults to ASC.", defaultValue = "ASC") @HeaderParam("Sort-Order") Order sortOrder);

    @GET
    @Path("/caseNoteSources")
    @Consumes({ "application/json" })
    @Produces({ "application/json" })
    @ApiOperation(value = "List of case note source codes.", notes = "List of case note source codes.", nickname="getCaseNoteSources")
    @ApiResponses(value = {
        @ApiResponse(code = 200, message = "OK", response = ReferenceCode.class, responseContainer = "List"),
        @ApiResponse(code = 400, message = "Invalid request.", response = ErrorResponse.class, responseContainer = "List"),
        @ApiResponse(code = 404, message = "Requested resource not found.", response = ErrorResponse.class, responseContainer = "List"),
        @ApiResponse(code = 500, message = "Unrecoverable error occurred whilst processing request.", response = ErrorResponse.class, responseContainer = "List") })
    GetCaseNoteSourcesResponse getCaseNoteSources(@ApiParam(value = "Requested offset of first record in returned collection of caseNoteSource records.", defaultValue = "0") @HeaderParam("Page-Offset") Long pageOffset,
                                                  @ApiParam(value = "Requested limit to number of caseNoteSource records returned.", defaultValue = "10") @HeaderParam("Page-Limit") Long pageLimit,
                                                  @ApiParam(value = "Comma separated list of one or more of the following fields - <b>code, description</b>") @HeaderParam("Sort-Fields") String sortFields,
                                                  @ApiParam(value = "Sort order (ASC or DESC) - defaults to ASC.", defaultValue = "ASC") @HeaderParam("Sort-Order") Order sortOrder);

    @GET
    @Path("/caseNoteTypes")
    @Consumes({ "application/json" })
    @Produces({ "application/json" })
    @ApiOperation(value = "List of all used case note types (with sub-types).", notes = "List of all used case note types (with sub-types).", nickname="getCaseNoteTypes")
    @ApiResponses(value = {
        @ApiResponse(code = 200, message = "OK", response = ReferenceCode.class, responseContainer = "List"),
        @ApiResponse(code = 400, message = "Invalid request.", response = ErrorResponse.class, responseContainer = "List"),
        @ApiResponse(code = 404, message = "Requested resource not found.", response = ErrorResponse.class, responseContainer = "List"),
        @ApiResponse(code = 500, message = "Unrecoverable error occurred whilst processing request.", response = ErrorResponse.class, responseContainer = "List") })
    GetCaseNoteTypesResponse getCaseNoteTypes();

    @GET
    @Path("/domains/{domain}")
    @Consumes({ "application/json" })
    @Produces({ "application/json" })
    @ApiOperation(value = "List of reference codes for reference domain.", notes = "List of reference codes for reference domain.", nickname="getReferenceCodesByDomain")
    @ApiResponses(value = {
        @ApiResponse(code = 200, message = "OK", response = ReferenceCode.class, responseContainer = "List"),
        @ApiResponse(code = 400, message = "Invalid request.", response = ErrorResponse.class, responseContainer = "List"),
        @ApiResponse(code = 404, message = "Requested resource not found.", response = ErrorResponse.class, responseContainer = "List"),
        @ApiResponse(code = 500, message = "Unrecoverable error occurred whilst processing request.", response = ErrorResponse.class, responseContainer = "List") })
    GetReferenceCodesByDomainResponse getReferenceCodesByDomain(@ApiParam(value = "The domain identifier/name.", required = true) @PathParam("domain") String domain,
                                                                @ApiParam(value = "Specify whether or not to return reference codes with their associated sub-codes.", defaultValue = "false") @QueryParam("withSubCodes") boolean withSubCodes,
                                                                @ApiParam(value = "Requested offset of first record in returned collection of domain records.", defaultValue = "0") @HeaderParam("Page-Offset") Long pageOffset,
                                                                @ApiParam(value = "Requested limit to number of domain records returned.", defaultValue = "10") @HeaderParam("Page-Limit") Long pageLimit,
                                                                @ApiParam(value = "Comma separated list of one or more of the following fields - <b>code, description</b>") @HeaderParam("Sort-Fields") String sortFields,
                                                                @ApiParam(value = "Sort order (ASC or DESC) - defaults to ASC.", defaultValue = "ASC") @HeaderParam("Sort-Order") Order sortOrder);

    @GET
    @Path("/domains/{domain}/codes/{code}")
    @Consumes({ "application/json" })
    @Produces({ "application/json" })
    @ApiOperation(value = "Reference code detail for reference domain and code (with sub-codes).", notes = "Reference code detail for reference domain and code (with sub-codes).", nickname="getReferenceCodeByDomainAndCode")
    @ApiResponses(value = {
        @ApiResponse(code = 200, message = "OK", response = ReferenceCode.class),
        @ApiResponse(code = 400, message = "Invalid request.", response = ErrorResponse.class),
        @ApiResponse(code = 404, message = "Requested resource not found.", response = ErrorResponse.class),
        @ApiResponse(code = 500, message = "Unrecoverable error occurred whilst processing request.", response = ErrorResponse.class) })
    GetReferenceCodeByDomainAndCodeResponse getReferenceCodeByDomainAndCode(@ApiParam(value = "The domain identifier/name.", required = true) @PathParam("domain") String domain,
                                                                            @ApiParam(value = "The reference code.", required = true) @PathParam("code") String code,
                                                                            @ApiParam(value = "Specify whether or not to return the reference code with its associated sub-codes.", defaultValue = "false") @QueryParam("withSubCodes") boolean withSubCodes);

    @GET
    @Path("/scheduleReasons")
    @Consumes({ "application/json" })
    @Produces({ "application/json" })
    @ApiOperation(value = "Get possible reason codes for created event.", notes = "Get possible reason codes for created event.", nickname="getScheduleReasons")
    @ApiResponses(value = {
        @ApiResponse(code = 200, message = "OK", response = ReferenceCode.class, responseContainer = "List"),
        @ApiResponse(code = 400, message = "Invalid request.", response = ErrorResponse.class, responseContainer = "List"),
        @ApiResponse(code = 404, message = "Requested resource not found.", response = ErrorResponse.class, responseContainer = "List"),
        @ApiResponse(code = 500, message = "Unrecoverable error occurred whilst processing request.", response = ErrorResponse.class, responseContainer = "List") })
    GetScheduleReasonsResponse getScheduleReasons(@ApiParam(value = "Specify event type.", required = true) @QueryParam("eventType") String eventType);

    class GetAlertTypesResponse extends ResponseDelegate {

        private GetAlertTypesResponse(Response response) { super(response); }
        private GetAlertTypesResponse(Response response, Object entity) { super(response, entity); }

        public static GetAlertTypesResponse respond200WithApplicationJson(Page<ReferenceCode> page) {
            ResponseBuilder responseBuilder = Response.status(200)
                    .header("Content-Type", MediaType.APPLICATION_JSON)
                    .header("Total-Records", page.getTotalRecords())
                    .header("Page-Offset", page.getPageOffset())
                    .header("Page-Limit", page.getPageLimit());
            responseBuilder.entity(page.getItems());
            return new GetAlertTypesResponse(responseBuilder.build(), page.getItems());
        }

        public static GetAlertTypesResponse respond400WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(400)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetAlertTypesResponse(responseBuilder.build(), entity);
        }

        public static GetAlertTypesResponse respond404WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(404)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetAlertTypesResponse(responseBuilder.build(), entity);
        }

        public static GetAlertTypesResponse respond500WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(500)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetAlertTypesResponse(responseBuilder.build(), entity);
        }
    }

    class GetCaseNoteSourcesResponse extends ResponseDelegate {

        private GetCaseNoteSourcesResponse(Response response) { super(response); }
        private GetCaseNoteSourcesResponse(Response response, Object entity) { super(response, entity); }

        public static GetCaseNoteSourcesResponse respond200WithApplicationJson(Page<ReferenceCode> page) {
            ResponseBuilder responseBuilder = Response.status(200)
                    .header("Content-Type", MediaType.APPLICATION_JSON)
                    .header("Total-Records", page.getTotalRecords())
                    .header("Page-Offset", page.getPageOffset())
                    .header("Page-Limit", page.getPageLimit());
            responseBuilder.entity(page.getItems());
            return new GetCaseNoteSourcesResponse(responseBuilder.build(), page.getItems());
        }

        public static GetCaseNoteSourcesResponse respond400WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(400)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetCaseNoteSourcesResponse(responseBuilder.build(), entity);
        }

        public static GetCaseNoteSourcesResponse respond404WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(404)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetCaseNoteSourcesResponse(responseBuilder.build(), entity);
        }

        public static GetCaseNoteSourcesResponse respond500WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(500)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetCaseNoteSourcesResponse(responseBuilder.build(), entity);
        }
    }

    class GetCaseNoteTypesResponse extends ResponseDelegate {

        private GetCaseNoteTypesResponse(Response response) { super(response); }
        private GetCaseNoteTypesResponse(Response response, Object entity) { super(response, entity); }

        public static GetCaseNoteTypesResponse respond200WithApplicationJson(List<ReferenceCode> entity) {
            ResponseBuilder responseBuilder = Response.status(200)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetCaseNoteTypesResponse(responseBuilder.build(), entity);
        }

        public static GetCaseNoteTypesResponse respond400WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(400)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetCaseNoteTypesResponse(responseBuilder.build(), entity);
        }

        public static GetCaseNoteTypesResponse respond404WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(404)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetCaseNoteTypesResponse(responseBuilder.build(), entity);
        }

        public static GetCaseNoteTypesResponse respond500WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(500)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetCaseNoteTypesResponse(responseBuilder.build(), entity);
        }
    }

    class GetReferenceCodesByDomainResponse extends ResponseDelegate {

        private GetReferenceCodesByDomainResponse(Response response) { super(response); }
        private GetReferenceCodesByDomainResponse(Response response, Object entity) { super(response, entity); }

        public static GetReferenceCodesByDomainResponse respond200WithApplicationJson(Page<ReferenceCode> page) {
            ResponseBuilder responseBuilder = Response.status(200)
                    .header("Content-Type", MediaType.APPLICATION_JSON)
                    .header("Total-Records", page.getTotalRecords())
                    .header("Page-Offset", page.getPageOffset())
                    .header("Page-Limit", page.getPageLimit());
            responseBuilder.entity(page.getItems());
            return new GetReferenceCodesByDomainResponse(responseBuilder.build(), page.getItems());
        }

        public static GetReferenceCodesByDomainResponse respond400WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(400)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetReferenceCodesByDomainResponse(responseBuilder.build(), entity);
        }

        public static GetReferenceCodesByDomainResponse respond404WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(404)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetReferenceCodesByDomainResponse(responseBuilder.build(), entity);
        }

        public static GetReferenceCodesByDomainResponse respond500WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(500)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetReferenceCodesByDomainResponse(responseBuilder.build(), entity);
        }
    }

    class GetReferenceCodeByDomainAndCodeResponse extends ResponseDelegate {

        private GetReferenceCodeByDomainAndCodeResponse(Response response) { super(response); }
        private GetReferenceCodeByDomainAndCodeResponse(Response response, Object entity) { super(response, entity); }

        public static GetReferenceCodeByDomainAndCodeResponse respond200WithApplicationJson(ReferenceCode entity) {
            ResponseBuilder responseBuilder = Response.status(200)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetReferenceCodeByDomainAndCodeResponse(responseBuilder.build(), entity);
        }

        public static GetReferenceCodeByDomainAndCodeResponse respond400WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(400)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetReferenceCodeByDomainAndCodeResponse(responseBuilder.build(), entity);
        }

        public static GetReferenceCodeByDomainAndCodeResponse respond404WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(404)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetReferenceCodeByDomainAndCodeResponse(responseBuilder.build(), entity);
        }

        public static GetReferenceCodeByDomainAndCodeResponse respond500WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(500)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetReferenceCodeByDomainAndCodeResponse(responseBuilder.build(), entity);
        }
    }

    class GetScheduleReasonsResponse extends ResponseDelegate {

        private GetScheduleReasonsResponse(Response response) { super(response); }
        private GetScheduleReasonsResponse(Response response, Object entity) { super(response, entity); }

        public static GetScheduleReasonsResponse respond200WithApplicationJson(List<ReferenceCode> entity) {
            ResponseBuilder responseBuilder = Response.status(200)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetScheduleReasonsResponse(responseBuilder.build(), entity);
        }

        public static GetScheduleReasonsResponse respond400WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(400)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetScheduleReasonsResponse(responseBuilder.build(), entity);
        }

        public static GetScheduleReasonsResponse respond404WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(404)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetScheduleReasonsResponse(responseBuilder.build(), entity);
        }

        public static GetScheduleReasonsResponse respond500WithApplicationJson(ErrorResponse entity) {
            ResponseBuilder responseBuilder = Response.status(500)
                    .header("Content-Type", MediaType.APPLICATION_JSON);
            responseBuilder.entity(entity);
            return new GetScheduleReasonsResponse(responseBuilder.build(), entity);
        }
    }
}