docker build --tag rp6l-dist --target dist . || exit 1
container_id=$(docker create rp6l-dist) || exit 1

if [[ -d ./dist ]]; then
    rm -rf ./dist || exit 1
fi

docker cp "${container_id}:/dist" ./dist || exit 1
docker rm "${container_id}" || exit 1

if [[ ! -d ./release ]]; then
    mkdir release || exit 1
fi

if [[ -f ./release/rp6l-linux.zip ]]; then
    rm -f ./release/rp6l-linux.zip || exit 1
fi

(cd dist && zip ../release/rp6l-linux.zip *) || exit 1
