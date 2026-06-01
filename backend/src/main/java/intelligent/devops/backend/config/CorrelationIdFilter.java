package intelligent.devops.backend.config;

import intelligent.devops.backend.api.CorrelationIdUtil;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.MDC;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

@Component
public class CorrelationIdFilter extends OncePerRequestFilter {

  @Value("${tracing.correlationHeader:X-Correlation-Id}")
  private String correlationHeader;

  @Override
  protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
      throws ServletException, IOException {

    String correlationId = request.getHeader(correlationHeader);
    if (correlationId == null || correlationId.isBlank()) {
      correlationId = CorrelationIdUtil.newCorrelationId();
    }

    MDC.put("correlationId", correlationId);
    response.setHeader(correlationHeader, correlationId);

    try {
      filterChain.doFilter(request, response);
    } finally {
      MDC.remove("correlationId");
    }
  }
}

