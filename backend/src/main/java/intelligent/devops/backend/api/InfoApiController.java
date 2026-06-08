package intelligent.devops.backend.api;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.LinkedHashMap;
import java.util.Map;

@RestController
@RequestMapping("/api")
public class InfoApiController {

  @Value("${GRAFANA_URL:http://grafana:3000}")
  private String grafanaUrl;

  @Value("${LOKI_URL:http://loki:3100}")
  private String lokiUrl;


  @GetMapping("/info")
  public ResponseEntity<Map<String, Object>> info(HttpServletRequest request) {
    String correlationId = CorrelationIdUtil.getCorrelationId(request);

    Map<String, Object> body = new LinkedHashMap<>();
    body.put("correlationId", correlationId);
    body.put("grafanaUrl", grafanaUrl);
    body.put("lokiUrl", lokiUrl);

    return new ResponseEntity<>(body, HttpStatus.OK);
  }
}

