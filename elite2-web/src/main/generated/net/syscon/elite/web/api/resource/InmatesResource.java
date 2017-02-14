
package net.syscon.elite.web.api.resource;

import java.util.List;
import javax.ws.rs.DefaultValue;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Response;
import net.syscon.elite.web.api.model.AssignedInmate;
import net.syscon.elite.web.api.model.HttpStatus;
import net.syscon.elite.web.api.model.InmateDetail;
import net.syscon.elite.web.api.model.Movement;


/**
 * The collection of inmates within the system.
 * 
 */
@Path("inmates")
public interface InmatesResource {


    /**
     * 
     * @param offset
     *     Skip over a number of elements by specifying an offset value for the query e.g. 20
     * @param limit
     *     Limit the number of elements on the response e.g. 80
     * @param orderBy
     *     Order by field: inmateId, bookingId, offenderId, firstName, lastName, alertCodes, agencyId, currentLocationId, or assignedLivingUnitId
     *     
     * @param order
     *     Order
     */
    @GET
    @Produces({
        "application/json"
    })
    InmatesResource.GetInmatesResponse getInmates(
        @QueryParam("orderBy")
        String orderBy,
        @QueryParam("order")
        @DefaultValue("asc")
        InmatesResource.Order order,
        @QueryParam("offset")
        @DefaultValue("0")
        int offset,
        @QueryParam("limit")
        @DefaultValue("10")
        int limit)
        throws Exception
    ;

    /**
     * 
     * @param inmateId
     *     
     */
    @GET
    @Path("inmates/{inmateId}")
    @Produces({
        "application/json"
    })
    InmatesResource.GetInmatesInmatesByInmateIdResponse getInmatesInmatesByInmateId(
        @PathParam("inmateId")
        String inmateId)
        throws Exception
    ;

    /**
     * 
     * @param inmateId
     *     
     * @param offset
     *     Skip over a number of elements by specifying an offset value for the query e.g. 20
     * @param limit
     *     Limit the number of elements on the response e.g. 80
     * @param orderBy
     *     Order by field: moveCategory, moveDateTime, fromAgencyId, toAgencyId, moveType, moveReason, fromLocationId, or toLocation
     *     
     * @param order
     *     Order
     */
    @GET
    @Path("inmates/{inmateId}/movements")
    @Produces({
        "application/json"
    })
    InmatesResource.GetInmatesInmatesByInmateIdMovementsResponse getInmatesInmatesByInmateIdMovements(
        @PathParam("inmateId")
        String inmateId,
        @QueryParam("orderBy")
        String orderBy,
        @QueryParam("order")
        @DefaultValue("asc")
        InmatesResource.Order order,
        @QueryParam("offset")
        @DefaultValue("0")
        int offset,
        @QueryParam("limit")
        @DefaultValue("10")
        int limit)
        throws Exception
    ;

    public class GetInmatesInmatesByInmateIdMovementsResponse
        extends net.syscon.elite.web.api.resource.support.ResponseWrapper
    {


        private GetInmatesInmatesByInmateIdMovementsResponse(Response delegate) {
            super(delegate);
        }

        /**
         * OK
         * 
         * @param entity
         *     
         */
        public static InmatesResource.GetInmatesInmatesByInmateIdMovementsResponse withJsonOK(List<Movement> entity) {
            Response.ResponseBuilder responseBuilder = Response.status(200).header("Content-Type", "application/json");
            responseBuilder.entity(entity);
            return new InmatesResource.GetInmatesInmatesByInmateIdMovementsResponse(responseBuilder.build());
        }

        /**
         *  e.g. {
         * 	"httpStatus": "400",
         * 	"code": "400",
         * 	"message": "Invalid request body",
         * 	"developerMessage": "The request could not be understood by the server due to malformed syntax. The client should not repeat the request without modifications.",
         * 	"moreInfo": ""
         * }
         * 
         * 
         * @param entity
         *     {
         *     	"httpStatus": "400",
         *     	"code": "400",
         *     	"message": "Invalid request body",
         *     	"developerMessage": "The request could not be understood by the server due to malformed syntax. The client should not repeat the request without modifications.",
         *     	"moreInfo": ""
         *     }
         *     
         */
        public static InmatesResource.GetInmatesInmatesByInmateIdMovementsResponse withJsonBadRequest(HttpStatus entity) {
            Response.ResponseBuilder responseBuilder = Response.status(400).header("Content-Type", "application/json");
            responseBuilder.entity(entity);
            return new InmatesResource.GetInmatesInmatesByInmateIdMovementsResponse(responseBuilder.build());
        }

        /**
         *  e.g. {
         * 	"httpStatus": "404",
         * 	"code": "404",
         * 	"message": "Resource not found",
         * 	"developerMessage": "The resource could not be found or the user does not have authorization to view the data.",
         * 	"moreInfo": ""
         * }
         * 
         * 
         * @param entity
         *     {
         *     	"httpStatus": "404",
         *     	"code": "404",
         *     	"message": "Resource not found",
         *     	"developerMessage": "The resource could not be found or the user does not have authorization to view the data.",
         *     	"moreInfo": ""
         *     }
         *     
         */
        public static InmatesResource.GetInmatesInmatesByInmateIdMovementsResponse withJsonNotFound(HttpStatus entity) {
            Response.ResponseBuilder responseBuilder = Response.status(404).header("Content-Type", "application/json");
            responseBuilder.entity(entity);
            return new InmatesResource.GetInmatesInmatesByInmateIdMovementsResponse(responseBuilder.build());
        }

        /**
         *  e.g. {
         *   "httpStatus": "500",
         *   "code": "500",
         *   "message": "Unexpected server error",
         *   "developerMessage": "Unexpected server error",
         *   "moreInfo": ""
         * }
         * 
         * 
         * @param entity
         *     {
         *       "httpStatus": "500",
         *       "code": "500",
         *       "message": "Unexpected server error",
         *       "developerMessage": "Unexpected server error",
         *       "moreInfo": ""
         *     }
         *     
         */
        public static InmatesResource.GetInmatesInmatesByInmateIdMovementsResponse withJsonInternalServerError(HttpStatus entity) {
            Response.ResponseBuilder responseBuilder = Response.status(500).header("Content-Type", "application/json");
            responseBuilder.entity(entity);
            return new InmatesResource.GetInmatesInmatesByInmateIdMovementsResponse(responseBuilder.build());
        }

    }

    public class GetInmatesInmatesByInmateIdResponse
        extends net.syscon.elite.web.api.resource.support.ResponseWrapper
    {


        private GetInmatesInmatesByInmateIdResponse(Response delegate) {
            super(delegate);
        }

        /**
         * OK
         * 
         * @param entity
         *     
         */
        public static InmatesResource.GetInmatesInmatesByInmateIdResponse withJsonOK(InmateDetail entity) {
            Response.ResponseBuilder responseBuilder = Response.status(200).header("Content-Type", "application/json");
            responseBuilder.entity(entity);
            return new InmatesResource.GetInmatesInmatesByInmateIdResponse(responseBuilder.build());
        }

        /**
         *  e.g. {
         * 	"httpStatus": "400",
         * 	"code": "400",
         * 	"message": "Invalid request body",
         * 	"developerMessage": "The request could not be understood by the server due to malformed syntax. The client should not repeat the request without modifications.",
         * 	"moreInfo": ""
         * }
         * 
         * 
         * @param entity
         *     {
         *     	"httpStatus": "400",
         *     	"code": "400",
         *     	"message": "Invalid request body",
         *     	"developerMessage": "The request could not be understood by the server due to malformed syntax. The client should not repeat the request without modifications.",
         *     	"moreInfo": ""
         *     }
         *     
         */
        public static InmatesResource.GetInmatesInmatesByInmateIdResponse withJsonBadRequest(HttpStatus entity) {
            Response.ResponseBuilder responseBuilder = Response.status(400).header("Content-Type", "application/json");
            responseBuilder.entity(entity);
            return new InmatesResource.GetInmatesInmatesByInmateIdResponse(responseBuilder.build());
        }

        /**
         *  e.g. {
         * 	"httpStatus": "404",
         * 	"code": "404",
         * 	"message": "Resource not found",
         * 	"developerMessage": "The resource could not be found or the user does not have authorization to view the data.",
         * 	"moreInfo": ""
         * }
         * 
         * 
         * @param entity
         *     {
         *     	"httpStatus": "404",
         *     	"code": "404",
         *     	"message": "Resource not found",
         *     	"developerMessage": "The resource could not be found or the user does not have authorization to view the data.",
         *     	"moreInfo": ""
         *     }
         *     
         */
        public static InmatesResource.GetInmatesInmatesByInmateIdResponse withJsonNotFound(HttpStatus entity) {
            Response.ResponseBuilder responseBuilder = Response.status(404).header("Content-Type", "application/json");
            responseBuilder.entity(entity);
            return new InmatesResource.GetInmatesInmatesByInmateIdResponse(responseBuilder.build());
        }

        /**
         *  e.g. {
         *   "httpStatus": "500",
         *   "code": "500",
         *   "message": "Unexpected server error",
         *   "developerMessage": "Unexpected server error",
         *   "moreInfo": ""
         * }
         * 
         * 
         * @param entity
         *     {
         *       "httpStatus": "500",
         *       "code": "500",
         *       "message": "Unexpected server error",
         *       "developerMessage": "Unexpected server error",
         *       "moreInfo": ""
         *     }
         *     
         */
        public static InmatesResource.GetInmatesInmatesByInmateIdResponse withJsonInternalServerError(HttpStatus entity) {
            Response.ResponseBuilder responseBuilder = Response.status(500).header("Content-Type", "application/json");
            responseBuilder.entity(entity);
            return new InmatesResource.GetInmatesInmatesByInmateIdResponse(responseBuilder.build());
        }

    }

    public class GetInmatesResponse
        extends net.syscon.elite.web.api.resource.support.ResponseWrapper
    {


        private GetInmatesResponse(Response delegate) {
            super(delegate);
        }

        /**
         * OK
         * 
         * @param entity
         *     
         */
        public static InmatesResource.GetInmatesResponse withJsonOK(List<AssignedInmate> entity) {
            Response.ResponseBuilder responseBuilder = Response.status(200).header("Content-Type", "application/json");
            responseBuilder.entity(entity);
            return new InmatesResource.GetInmatesResponse(responseBuilder.build());
        }

        /**
         *  e.g. {
         * 	"httpStatus": "400",
         * 	"code": "400",
         * 	"message": "Invalid request body",
         * 	"developerMessage": "The request could not be understood by the server due to malformed syntax. The client should not repeat the request without modifications.",
         * 	"moreInfo": ""
         * }
         * 
         * 
         * @param entity
         *     {
         *     	"httpStatus": "400",
         *     	"code": "400",
         *     	"message": "Invalid request body",
         *     	"developerMessage": "The request could not be understood by the server due to malformed syntax. The client should not repeat the request without modifications.",
         *     	"moreInfo": ""
         *     }
         *     
         */
        public static InmatesResource.GetInmatesResponse withJsonBadRequest(HttpStatus entity) {
            Response.ResponseBuilder responseBuilder = Response.status(400).header("Content-Type", "application/json");
            responseBuilder.entity(entity);
            return new InmatesResource.GetInmatesResponse(responseBuilder.build());
        }

        /**
         *  e.g. {
         * 	"httpStatus": "404",
         * 	"code": "404",
         * 	"message": "Resource not found",
         * 	"developerMessage": "The resource could not be found or the user does not have authorization to view the data.",
         * 	"moreInfo": ""
         * }
         * 
         * 
         * @param entity
         *     {
         *     	"httpStatus": "404",
         *     	"code": "404",
         *     	"message": "Resource not found",
         *     	"developerMessage": "The resource could not be found or the user does not have authorization to view the data.",
         *     	"moreInfo": ""
         *     }
         *     
         */
        public static InmatesResource.GetInmatesResponse withJsonNotFound(HttpStatus entity) {
            Response.ResponseBuilder responseBuilder = Response.status(404).header("Content-Type", "application/json");
            responseBuilder.entity(entity);
            return new InmatesResource.GetInmatesResponse(responseBuilder.build());
        }

        /**
         *  e.g. {
         *   "httpStatus": "500",
         *   "code": "500",
         *   "message": "Unexpected server error",
         *   "developerMessage": "Unexpected server error",
         *   "moreInfo": ""
         * }
         * 
         * 
         * @param entity
         *     {
         *       "httpStatus": "500",
         *       "code": "500",
         *       "message": "Unexpected server error",
         *       "developerMessage": "Unexpected server error",
         *       "moreInfo": ""
         *     }
         *     
         */
        public static InmatesResource.GetInmatesResponse withJsonInternalServerError(HttpStatus entity) {
            Response.ResponseBuilder responseBuilder = Response.status(500).header("Content-Type", "application/json");
            responseBuilder.entity(entity);
            return new InmatesResource.GetInmatesResponse(responseBuilder.build());
        }

    }

    public enum Order {

        desc,
        asc;

    }

}
