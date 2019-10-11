#!/bin/bash

POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -u|--username)
    USERNAME="$2"
    shift # past argument
    shift # past value
    ;;
    -t|--token)
    TOKEN="$2"
    shift # past argument
    shift # past value
    ;;
    -so|--source-org)
    SOURCE_ORG="$2"
    shift # past argument
    shift # past value
    ;;
    -sr|--source-repo)
    SOURCE_REPO="$2"
    shift # past argument
    shift # past value
    ;;
    -do|--dest-org)
    DEST_ORG="$2"
    shift # past argument
    shift # past value
    ;;
    -dr|--dest-repo)
    DEST_REPO="$2"
    shift # past argument
    shift # past value
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

COMMAND=$1

if [[ -z $USERNAME || -z $TOKEN || -z $SOURCE_ORG || -z $SOURCE_REPO || -z $DEST_ORG || -z $DEST_REPO ]]
  then
    echo "Error: Missing parameters, all options are required"
    echo ""
    echo ""
    echo "Parameters:"
    echo "(required) -u  | --username {Github username}"
    echo "           -t  | --token {Github personal access token}"
    echo "           -so | --source-org {The organization/user of the source repo}"
    echo "           -sr | --source-repo {The source repo}"
    echo "           -do | --dest-org {The organization/user of the destination repo}"
    echo "           -dr | --dest-repo {The destination repo}"
    exit 1
fi

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

core_copy
valence_copy
