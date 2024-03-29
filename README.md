# Docker image for AnyCross Agent

This project contains a Dockerfile to Dockerize the AnyCross Agent. See
[On-prem Service Intro](https://www.larksuite.com/hc/en-US/articles/135828117644-on-prem-service-intro)
for more information.

# Usage

```
docker run glints/anycross-agent:latest
```

The image supports the following environment variables:

- `TOKEN`: Token to authenticate against AnyCross. Only required on first run.
- `ANYCROSS_REGION`: Either `sg`, `jp` or `us`.

It's recommended that `/workspace` is mounted to a persistent volume.
