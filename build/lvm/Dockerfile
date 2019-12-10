FROM ubuntu:18.10

RUN apt update && apt upgrade -y && apt install -y ca-certificates file tzdata
COPY nsenter /nsenter

COPY lvm.csi.quantil.com /bin/lvm.csi.quantil.com
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /bin/lvm.csi.quantil.com && chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
