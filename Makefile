GOFMT_FILES?=$$(find . -type f -name '*.go')

default: dev

dev: tidy fmt
	@go build -race -o "$(CURDIR)/bin/shell-setup" .

fmt:
	@gofmt -w $(GOFMT_FILES)

tidy:
	@go mod tidy

clean:
	@rm -rf "$(CURDIR)/bin"
	@rm -rf "$(CURDIR)/dist"

.NOTPARALLEL:

.PHONY: bin default dev fmtcheck fmt tidy