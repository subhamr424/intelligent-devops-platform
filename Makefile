.PHONY: help build test docker scan deploy rollback clean

PROJECT_NAME=intelligent-devops-platform

help:
	@echo "Make targets:"
	@echo "  make build     - Build backend and frontend"
	@echo "  make test      - Run tests"
	@echo "  make docker    - Build Docker images"
	@echo "  make scan      - Run security scans (Trivy/OWASP)"
	@echo "  make deploy    - Deploy via scripts/deploy.sh"
	@echo "  make rollback  - Roll back via scripts/rollback.sh"
	@echo "  make clean     - Clean build artifacts"

build:
	$(MAKE) -C backend build
	$(MAKE) -C frontend build
	touch .make_build_done
	echo "Build complete"

test:
	$(MAKE) -C backend test
	echo "Tests complete"

docker:
	./scripts/build.sh
	echo "Docker build complete"

scan:
	./scripts/build.sh scan
	./scripts/build.sh scan-frontend

deploy:
	./scripts/deploy.sh

rollback:
	./scripts/rollback.sh

clean:
	rm -rf backend/target frontend/build frontend/dist .make_build_done
	@echo "Clean complete"

