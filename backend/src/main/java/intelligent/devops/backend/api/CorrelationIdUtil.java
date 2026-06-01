package intelligent.devops.backend.api;

import jakarta.servlet.http.HttpServletRequest;

import java.util.UUID;

public class CorrelationIdUtil {

  public static String getCorrelationId(HttpServletRequest request) {
    String headerName = System.getenv().getOrDefault("X_CORRELATION_HEADER", "X-Correlation-Id");
    String fromHeader = request.getHeader(headerName);
    if (fromHeader != null && !fromHeader.isBlank()) {
      return fromHeader;
    }
    return "";
  }

  public static String newCorrelationId() {
    return UUID.randomUUID().toString();
  }
}

