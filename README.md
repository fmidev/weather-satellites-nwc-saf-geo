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


## Building

```bash
podman build -t nwcgeo -f Dockerfile .
```

## Usage

TODO
