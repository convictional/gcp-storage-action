Update January 2026: This repository is now archived. 

# GCP Storage Action

Simple action for uploading and downloading file with GCP storage.

| Argument            | Required | Default  | Description                                                |
| ------------------- | -------- | -------- | ---------------------------------------------------------- |
| `source_file`       | Yes      | N/A      | Where the file is being copied from. This can be either a local file or a `gs://` file path. `source_file` or `destination_file` must have `gs://`. |
| `destination_file`  | Yes      | N/A      | Where the file is going to be. This can be either a local file or a `gs://` file path. |
| `application_credentials`       | Yes      | N/A      | These are the IAM credentials for accessing the GCP bucket. |
| `project_id`       | Yes      | N/A      | The project id that the bucket lives under. |


## Examples

```
- uses: convictional/gcp-storage-action@master
  with:
    source_file: ./local_file.txt
    destination_file: gs://yourbucket/folder/local_file.txt
    application_credentials: ${{ secrets.GCP_AUTH }}
    project_id: myproject_on_gcp
```

## Development

```
docker build . -t gcp-storage-action
docker run gcp-storage-action --env INPUT_SOURCE_FILE='' --env INPUT_DESTINATION_FILE=''
```
