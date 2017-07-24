package net.syscon.elite.web.config;

import net.syscon.elite.aop.LoggingAspect;
import net.syscon.elite.aop.OracleConnectionAspect;
import net.syscon.util.SQLProvider;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.context.annotation.Profile;

@Configuration
@EnableAspectJAutoProxy
public class AopConfigs {

    @Bean
    public LoggingAspect loggingAspect() {
        return new LoggingAspect();
    }

    @Bean
	@Profile("!noproxy")
	public OracleConnectionAspect oracleProxyConnectionAspect(SQLProvider sqlProvider,
                                                              @Value("${app.url}") String jdbcUrl,
                                                              @Value("${app.username}") String username,
                                                              @Value("${app.password}") String password
                                                              ) {
        return new OracleConnectionAspect(sqlProvider, jdbcUrl, username, password);
	}

}
