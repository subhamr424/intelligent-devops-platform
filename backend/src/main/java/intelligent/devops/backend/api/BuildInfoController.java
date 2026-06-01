package intelligent.devops.backend.api;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.Instant;
import java.util.LinkedHashMap;
import java.util.Map;

@RestController
@RequestMapping("/api")
public class BuildInfoController {

  @Value("${build.version:unknown}")
  private String buildVersion;

  @Value("${build.commit:unknown}")
  private String buildCommit;

  @Value("${build.branch:unknown}")
  private String buildBranch;

  @Value("${build.timestamp:unknown}")
  private String buildTimestamp;

  @GetMapping("/build")
  public ResponseEntity<Map<String, Object>> build(HttpServletRequest request) {
    String correlationId = CorrelationIdUtil.getCorrelationId(request);

    Map<String, Object> body = new LinkedHashMap<>();
    body.put("correlationId", correlationId);
    body.put("version", buildVersion);
    body.put("commit", buildCommit);
    body.put("branch", buildBranch);
    body.put("timestamp", buildTimestamp);
    body.put("serverTime", Instant.now().toString());

    return new ResponseEntity<>(body, HttpStatus.OK);
  }
}

