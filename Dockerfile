FROM google/cloud-sdk:293.0.0-alpine

COPY LICENSE README.md /

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["sh", "/entrypoint.sh"]
