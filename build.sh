#!/bin/bash

. build.conf

for IMAGE in common auth-server resource-server addon-administration addon-self-administration; do
    echo 
    echo "-----------------------------------------------"
    echo "-- building: $IMAGE"
    echo "-----------------------------------------------"

    export IMAGE

    mkdir -p build/$IMAGE
    test -e build/$IMAGE/osiam-${IMAGE}_${OSIAM_VERSION}_all.deb \
        || curl -o build/$IMAGE/osiam-${IMAGE}_${OSIAM_VERSION}_all.deb -L https://github.com/osiam/distribution/releases/download/v${OSIAM_VERSION}/osiam-${IMAGE}_${OSIAM_VERSION}_all.deb \
        || exit 1
    cat $IMAGE/Dockerfile.in | envsubst > build/$IMAGE/Dockerfile

    test -e $IMAGE/conf && cp -r $IMAGE/conf build/$IMAGE/
    test -e $IMAGE/conf/${IMAGE}.properties \
        && cat $IMAGE/conf/${IMAGE}.properties | envsubst > build/$IMAGE/conf/${IMAGE}.properties

    docker build --tag $REGISTRY/osiam-$IMAGE build/$IMAGE
    docker build --tag $REGISTRY/osiam-$IMAGE:$OSIAM_VERSION build/$IMAGE
done

echo 
echo "-----------------------------------------------"
echo "-- building: osiam postgres image"
echo "-----------------------------------------------"

mkdir -p build/postgresql
cat postgresql/Dockerfile.in | envsubst > build/postgresql/Dockerfile
cp -r postgresql/conf build/postgresql/
docker build --tag postgresql/osiam-postgresql:$OSIAM_VERSION build/postgresql
