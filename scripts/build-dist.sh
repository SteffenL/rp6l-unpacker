docker build --tag rp6l-dist --target dist . || exit 1
container_id=$(docker create rp6l-dist) || exit 1

if [[ -d build/bin ]]; then
    rm -rd build/bin || exit 1
fi

if [[ -d build/dist ]]; then
    rm -rd build/dist || exit 1
fi

if [[ ! -d build ]]; then
    mkdir build || exit 1
fi

docker cp "${container_id}:/dist" build/bin || exit 1
docker rm "${container_id}" || exit 1

if [[ ! -d build/dist ]]; then
    mkdir build/dist || exit 1
fi

(cd build/bin && zip ../dist/rp6l-linux.zip *) || exit 1
