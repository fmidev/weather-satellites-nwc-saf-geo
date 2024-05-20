FROM ubuntu:22.04 AS builder

WORKDIR /tmp

RUN apt update && \
    apt -y upgrade && \
    apt -y install tar gzip gcc make m4 cmake libaec-dev libaec0 bash ksh cpp g++ gfortran perl patch && \
    apt -y clean

ENV SAFNWC=/opt/nwcsaf

COPY NWC-CDOP3-GEO-AEMET-SW-CODE-COTS_v2021.3_01MAR24.tgz /tmp
COPY NWC-CDOP3-GEO-AEMET-SW-CODE-SYSTEM_v2021.3_01MAR24.tgz /tmp
COPY nwcgeo_v2021.3 /tmp
COPY nwcgeo_v2021.3.patch /tmp
COPY nwcgeo_v2021.3_env.sh /tmp

RUN cd /tmp && \
    patch nwcgeo_v2021.3 nwcgeo_v2021.3.patch && \
    ./nwcgeo_v2021.3 install

RUN rm -rf /opt/nwcsaf/COTS/bufrdc_000400 && \
    rm -rf /opt/nwcsaf/COTS/bufrtables && \
    rm -rf /opt/nwcsaf/COTS/eccodes-2.30.2-Source && \
    rm -rf /opt/nwcsaf/COTS/hdf5-1.8.17 && \
    rm -rf /opt/nwcsaf/COTS/ipl98 && \
    rm -rf /opt/nwcsaf/COTS/netcdf-4.4.1 && \
    rm -rf /opt/nwcsaf/COTS/netcdf-fortran-4.2 && \
    rm -rf /opt/nwcsaf/COTS/packages && \
    rm -rf /opt/nwcsaf/COTS/rtbrdf_rttov11 && \
    rm -rf /opt/nwcsaf/COTS/rtcoef_rttov11 && \
    rm -rf /opt/nwcsaf/COTS/rtemis_rttov11 && \
    rm -rf /opt/nwcsaf/COTS/rttov_11.2 && \
    rm -rf /opt/nwcsaf/COTS/zlib-1.2.11 && \
    rm -rf /opt/nwcsaf/src && \
    rm -rf /opt/nwcsaf/import/*

FROM ubuntu:22.04

RUN apt update && \
    apt -y upgrade && \
    apt -y install libaec0 bash ksh perl libgomp1 libgfortran5 && \
    apt -y clean

COPY --from=builder /opt/nwcsaf /opt/nwcsaf
COPY --from=builder /root/.nwcgeo /opt/nwcsaf
COPY entrypoint.sh /usr/bin/

ENTRYPOINT ["/usr/bin/entrypoint.sh"]
