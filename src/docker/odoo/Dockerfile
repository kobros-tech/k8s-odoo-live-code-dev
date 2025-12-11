FROM ubuntu:jammy

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        dirmngr \
        fonts-noto-cjk \
        gnupg \
        libssl-dev \
        node-less \
        npm \
        python3-magic \
        python3-num2words \
        python3-odf \
        python3-pdfminer \
        python3-pip \
        python3-phonenumbers \
        python3-pyldap \
        python3-qrcode \
        python3-renderpm \
        python3-setuptools \
        python3-slugify \
        python3-vobject \
        python3-watchdog \
        python3-xlrd \
        python3-xlwt \
        xz-utils && \
    if [ -z "${TARGETARCH}" ]; then \
        TARGETARCH="$(dpkg --print-architecture)"; \
    fi; \
    WKHTMLTOPDF_ARCH=${TARGETARCH} && \
    case ${TARGETARCH} in \
    "amd64") WKHTMLTOPDF_ARCH=amd64 && WKHTMLTOPDF_SHA=967390a759707337b46d1c02452e2bb6b2dc6d59  ;; \
    "arm64")  WKHTMLTOPDF_SHA=90f6e69896d51ef77339d3f3a20f8582bdf496cc  ;; \
    "ppc64le" | "ppc64el") WKHTMLTOPDF_ARCH=ppc64el && WKHTMLTOPDF_SHA=5312d7d34a25b321282929df82e3574319aed25c  ;; \
    esac \
    && curl -o wkhtmltox.deb -sSL https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6.1-3/wkhtmltox_0.12.6.1-3.jammy_${WKHTMLTOPDF_ARCH}.deb \
    && echo ${WKHTMLTOPDF_SHA} wkhtmltox.deb | sha1sum -c - \
    && apt-get install -y --no-install-recommends ./wkhtmltox.deb \
    && rm -rf /var/lib/apt/lists/* wkhtmltox.deb

RUN apt-get update && \ 
    apt-get install --no-install-recommends -y \
    build-essential \
    libpq-dev \
    python3-dev \
    gcc \
    git

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
        libldap2-dev \
        libsasl2-dev

# Install rtlcss (on Debian buster)
RUN npm install -g rtlcss

# Retrieve the target architecture to install the correct wkhtmltopdf package
ARG TARGETARCH

# Work directory
WORKDIR /app

# Copy your Odoo code and requirements placeholder
COPY requirements.txt /app/requirements.txt

# Install Python deps
RUN pip install --no-cache-dir -r requirements.txt

# Download source code that dones't need development
RUN pip install git-aggregator
COPY repos.yaml /app/repos.yaml
RUN gitaggregate -c repos.yaml

# Copy the code that needs development
COPY odoo-llm/ /app/odoo-llm/

COPY odoo.conf /app/odoo.conf

# Copy entrypoint (start odoo)
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose Odoo ports
EXPOSE 8069 8072

# Start Odoo
CMD ["/entrypoint.sh"]
