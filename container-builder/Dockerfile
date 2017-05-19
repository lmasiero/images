FROM debian:8.8

# Install Google Cloud SDK
ENV CLOUDSDK_CORE_DISABLE_PROMPTS=1 \
    GOOGLE_CLOUD_SDK_VERSION=154.0.0 \
    PATH=/opt/google-cloud-sdk/bin:$PATH
RUN set -x \
    && cd /opt \
    && echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
    && apt-get update \
    && apt-get install --no-install-recommends -y jq wget python git localepurge ca-certificates \
    && wget -q https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${GOOGLE_CLOUD_SDK_VERSION}-linux-x86_64.tar.gz \
    && tar zxfv google-cloud-sdk-${GOOGLE_CLOUD_SDK_VERSION}-linux-x86_64.tar.gz \
    && ./google-cloud-sdk/install.sh \
    && gcloud components install kubectl
    
 COPY ./entrypoint.sh /
 ENTRYPOINT ["/entrypoint.sh"]
