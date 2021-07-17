# RP6L Unpacker

This is an RP6L file unpacker based on [source code](https://gist.github.com/hhrhhr/c270fa8dd41abcc08f0cab652164130b) by [hhrhhr](https://gist.github.com/hhrhhr).

All source code is licensed under the terms in `LICENSE` except for the original Lua scripts by hhrhhr which are copyrighted by their rightful owners.

## Building

```
docker build -t rp6l .
```

## Usage

```
docker run --rm \
    --volume "RPACK_DIR:/tmp/rp6l/in" \
    --volume "OUT_DIR:/tmp/rp6l/out" \
    rp6l /tmp/rp6l/in/RPACK_FILE /tmp/rp6l/out
```

Replace the following:

```
RPACK_DIR   Full path of the directory containing rpack files.
            Example: ${HOME}/.steam/steam/steamapps/common/Dying Light/DW/Data

OUT_DIR     Full path of the directory to unpack files into. A new subdirectory
            will be created in there with the same name as the rpack file.
            Example: ${PWD}/out

RPACK_FILE  The relative path of the rpack file to extract.
```
