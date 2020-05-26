#!/bin/sh

function usage_docs {
  echo ""
  echo "You can use this Github Action with:"
  echo "- uses: convictional/gcp-storage-action@master"
  echo "  with:"
  echo "    source_file: ./local_file.txt"
  echo "    destination_file: gs://yourbucket/folder/local_file.txt"
  echo "    application_credentials: \${{ secrets.GCP_AUTH }}"
  echo "    project_id: myproject_on_gcp"
  echo ""
  echo "For more information, please visit: https://github.com/convictional/gcp-storage-action"
  echo ""
}

function validate_required_inputs {
  if [ -z "$INPUT_SOURCE_FILE" ]
  then
    echo "Error: Source file was not found. Found :: [$INPUT_SOURCE_FILE]"
    usage_docs
    exit 1
  fi

  if [ -z "$INPUT_DESTINATION_FILE" ]
  then
    echo "Error: Destination file was not found. Found :: [$INPUT_DESTINATION_FILE]"
    usage_docs
    exit 1
  fi

  if [[ $INPUT_SOURCE_FILE != *"gs://"* ] || [ $INPUT_DESTINATION_FILE != *"gs://"* ]]
  then
    echo "Error: Destination file or source file must have gs://."
    usage_docs
    exit 1
  fi
}

function get_action {
  echo "cp"
}

function get_flags {
  if [ -z  $INPUT_FLAGS ]
  then
    echo ""
  else
    echo "$INPUT_FLAGS"
  fi
}

function setup_gcp_config {
  # Check for project id
  if [ -z "$INPUT_PROJECT_ID" ]
  then
    echo "Project id was not found. Using the configuration settings from a previous step."
  else
    gcloud config set project "$INPUT_PROJECT_ID"
  fi

  # Check for creds
  if [ -z "$INPUT_APPLICATION_CREDENTIALS" ]
  then
    echo "Application credentials was not found. Using the configuration settings from a previous step."
  else
    echo "$INPUT_APPLICATION_CREDENTIALS" | base64 -d > /tmp/account.json
    gcloud auth activate-service-account --key-file=/tmp/account.json
  fi
}

function main {
  validate_required_inputs
  setup_gcp_config
  action=$(get_action)
  flags=$(get_flags)

  # https://cloud.google.com/storage/docs/gsutil/commands/cp
  sh -c "gsutil $flags $action $INPUT_SOURCE_FILE $INPUT_DESTINATION_FILE"
}

main
