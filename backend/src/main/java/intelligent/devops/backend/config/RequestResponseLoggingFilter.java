package intelligent.devops.backend.config;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.MDC;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

@Component
public class RequestResponseLoggingFilter extends OncePerRequestFilter {

  private static final Logger log = LoggerFactory.getLogger(RequestResponseLoggingFilter.class);

  @Override
  protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
      throws ServletException, IOException {

    long start = System.nanoTime();
    try {
      filterChain.doFilter(request, response);
    } finally {
      long durationMs = (System.nanoTime() - start) / 1_000_000;
      String correlationId = MDC.get("correlationId");

      // Structured-ish JSON line for Loki ingestion (JSON log encoder is configured in logback)
      log.info(
          "{{\"event\":\"request\",\"method\":\"{}\",\"path\":\"{}\",\"status\":{},\"durationMs\":{},\"correlationId\":\"{}\"}}",
          request.getMethod(),
          request.getRequestURI(),
          response.getStatus(),
          durationMs,
          correlationId == null ? "" : correlationId
      );
    }
  }
}

