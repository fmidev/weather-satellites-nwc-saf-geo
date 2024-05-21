# Recipe to build NWC SAF GEO as a container

## Existing files

The files present in the repository are:

* `README.md` - this file
* `Dockerfile` - build recipe
* `entrypoint.sh` - file to be run when the container is started
* `nwcgeo_v2021.3.patch` - a patch file that is applied to the original installation script to make the installation automatic


## External files needed

The following files are part of the NWC SAF GEO software package, and
can not be included in the repository.  Please copy these files to
this directory before building.

* `nwcgeo_v2021.3` - the original unchanged build script
* `nwcgeo_v2021.3_env.sh` - environment variable template for the build script
* `NWC-CDOP3-GEO-AEMET-SW-CODE-SYSTEM_v2021.3_01MAR24.tgz` - the core code
* `NWC-CDOP3-GEO-AEMET-SW-CODE-COTS_v2021.3_01MAR24.tgz` - the COTS software packages
* `nwcgeo_v2021.3.patch` - a patch to make installation non-interactive and sets FMI as production centre


## Building

```bash
podman build -t nwcgeo -f Dockerfile .
```

## Usage

See the below script how to use the container with Podman, and NWC SAF
GEO manuals for details.

```bash
#!/bin/bash

# Set the base directory where the respective directories are in the host
BASE_EXT_DIR=
NWCSAF=/opt/nwcsaf

podman run --rm \
       -v ${BASE_EXT_DIR}/config_v2021.3:${NWCSAF}/config \
       -v ${BASE_EXT_DIR}/export:${NWCSAF}/export \
       -v ${BASE_EXT_DIR}/import:${NWCSAF}/import \
       -v ${BASE_EXT_DIR}/logs:${NWCSAF}/logs \
       -v ${BASE_EXT_DIR}/tmp:${NWCSAF}/tmp \
       nwcgeo
```

Notes:
* `export/` needs to have all the subdirectories pre-created
* `config_v2021.3/` needs to be based on the `config/` directory contents after GEO compilation
* `${NWCSAF}/COTS/bufrtables/` isn't included in the image, so mount them if BUFR output is needed (default in `config_v2021.3/safnwc_HRW.cfm`)
