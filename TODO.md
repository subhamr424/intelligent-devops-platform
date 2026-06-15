# TODO - Build Fixes (DevSecOps)

## Step 1: Root cause analysis (done)
- Validate suppression XML schema incompatibility with dependency-check 12.1.3.
- Identify OSS Index 401 likely due to missing auth token.
- Identify Jenkins secret interpolation warning in Slack notification.

## Step 2: Implement code fixes (in progress)
1. ✅ Update `backend/src/main/resources/dependency-check-suppressions.xml` to a schema-valid OWASP Dependency Check suppressions format.
2. Update `backend/pom.xml`:
   - Set Java 21 compatibility.
   - Configure dependency-check 12.1.3 properly for OSS Index auth.
   - Ensure suppression file is referenced correctly.
3. Update `jenkins/Jenkinsfile`:
   - Fix insecure secret interpolation for Slack webhook.
   - Keep SonarQube enabled.



## Step 3: Verification
- Run: `mvn -f backend/pom.xml clean verify`
- Run: `mvn -f backend/pom.xml verify sonar:sonar`

## Step 4: Security impact assessment
- Confirm scans remain enabled.
- Confirm OSS Index auth uses secure credentials.
- Confirm Jenkins no longer interpolates secrets into shell commands.

