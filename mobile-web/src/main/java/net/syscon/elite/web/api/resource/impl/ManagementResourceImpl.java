package net.syscon.elite.web.api.resource.impl;


import org.springframework.boot.actuate.endpoint.DumpEndpoint;
import org.springframework.boot.actuate.endpoint.HealthEndpoint;
import org.springframework.boot.actuate.endpoint.InfoEndpoint;
import org.springframework.boot.actuate.endpoint.MetricsEndpoint;
import org.springframework.stereotype.Component;

import javax.inject.Inject;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.StreamingOutput;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.lang.management.ThreadInfo;

@Path("/management")
@Produces({MediaType.APPLICATION_JSON})
@Component
public class ManagementResourceImpl {

	private HealthEndpoint healthEndpoint;
	private MetricsEndpoint metricsEndpoint;
	private DumpEndpoint dumpEndpoint;
	private InfoEndpoint infoEndpoint;

	@Inject
	public void setHealthEndpoint(HealthEndpoint healthEndpoint) {
		this.healthEndpoint = healthEndpoint;
	}

	@Inject
	public void setMetricsEndpoint(MetricsEndpoint metricsEndpoint) {
		this.metricsEndpoint = metricsEndpoint;
	}

	@Inject
	public void setDumpEndpoint(DumpEndpoint dumpEndpoint) {
		this.dumpEndpoint = dumpEndpoint;
	}

	@Inject
	public void setInfoEndpoint(InfoEndpoint infoEndpoint) {
		this.infoEndpoint = infoEndpoint;
	}

	@GET
	@Path("/info")
	public Object getInfoEndpoint() {
		return infoEndpoint.invoke();
	}


	@GET
	@Path("/health")
	public Object getHealthEndpoint() {
		return healthEndpoint.invoke();
	}

	@GET
	@Path("/metrics")
	public Object getMetricsEndpoint() {
		return this.metricsEndpoint.invoke();
	}

	@GET
	@Path("/metrics/{name:.*}")
	public Object getMetric(@PathParam("name") final String name) {
		final Object value = this.metricsEndpoint.invoke().get(name);
		if (value == null) {
			throw new NotFoundException("No such metric: " + name);
		}
		return value;
	}

	@GET
	@Path("/dump")
	@Produces(MediaType.TEXT_PLAIN)
	public Object getThreadDump() {

		return new StreamingOutput() {

			@Override
			public void write(java.io.OutputStream out) throws IOException, WebApplicationException {
				final Writer writer = new BufferedWriter(new OutputStreamWriter(out));
				for (final ThreadInfo thread : dumpEndpoint.invoke()) {
					writer.write(thread.toString());
				}

				writer.flush();
			}
		};


	}
}