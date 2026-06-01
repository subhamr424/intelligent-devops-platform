package intelligent.devops.backend.api;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.LinkedHashMap;
import java.util.Map;

@RestController
@RequestMapping("/api")
public class HealthApiController {

  @GetMapping("/health")
  public ResponseEntity<Map<String, Object>> health(HttpServletRequest request) {
    Map<String, Object> body = new LinkedHashMap<>();
    body.put("status", "UP");
    body.put("correlationId", CorrelationIdUtil.getCorrelationId(request));
    body.put("service", "intelligent-devops-platform-backend");

    return new ResponseEntity<>(body, HttpStatus.OK);
  }
}

