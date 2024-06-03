FROM ppc64le/golang:1.22-alpine as builder
WORKDIR /kube-sentry
COPY . .
RUN go build -ldflags "-s -w" -v -o /kube-sentry/kube-sentry /kube-sentry/cmd

FROM scratch
LABEL name="ghcr.io/ghcr.io/ppc64le-cloud/kube-sentry:v0.1" \
      description="Servicelog event notifier for ppc64le."
COPY --from=builder /kube-sentry/kube-sentry /usr/bin/kube-sentry
WORKDIR /
CMD ["/usr/bin/kube-sentry"]
