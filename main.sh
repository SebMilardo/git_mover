#!/bin/bash

USERNAME=$1
TOKEN=$2
SOURCE_ORG=$3
SOURCE_REPO=$4
DEST_ORG=$5
DEST_REPO=$6

core_copy() {
    git clone --bare https://github.com/$SOURCE_ORG/$SOURCE_REPO.git
    cd $SOURCE_REPO.git
    git push --mirror https://github.com/$DEST_ORG/$DEST_REPO.git
    cd ..
    rm -rf $SOURCE_REPO.git
}

valence_copy() {
    python ./git-mover.py $USERNAME $TOKEN $SOURCE_ORG/$SOURCE_REPO $DEST_ORG/$DEST_REPO
}

if [ $# -ge 6 ]; then
    core_copy
    valence_copy
else
    echo "This command requires 6 positional arguments: username token source_organization source_repo destination_organization destination_repo"
fi
