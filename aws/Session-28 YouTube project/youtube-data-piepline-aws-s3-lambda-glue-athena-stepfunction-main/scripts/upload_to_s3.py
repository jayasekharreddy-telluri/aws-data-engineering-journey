import boto3
from pathlib import Path

BUCKET_NAME = "yt-data-pipeline-bronze-ap-south-1-dev-jai"

DATA_DIR = Path(
    r"C:\aws-data-engineering-journey\aws\Session-28 YouTube project\youtube-data-piepline-aws-s3-lambda-glue-athena-stepfunction-main\youtube-data-piepline-aws-s3-lambda-glue-athena-stepfunction-main\data"
)

s3 = boto3.client("s3")

for file in DATA_DIR.iterdir():

    if file.suffix.lower() == ".csv":

        region = file.stem[:2].lower()

        s3_key = (
            f"youtube/raw_statistics/"
            f"region={region}/"
            f"{file.name}"
        )

        print(f"Uploading {file.name} -> {s3_key}")

        s3.upload_file(str(file), BUCKET_NAME, s3_key)

    elif file.suffix.lower() == ".json":

        region = file.name[:2].lower()

        s3_key = (
            f"youtube/raw_statistics_reference_data/"
            f"region={region}/"
            f"{file.name}"
        )

        print(f"Uploading {file.name} -> {s3_key}")

        s3.upload_file(str(file), BUCKET_NAME, s3_key)

print("Upload completed successfully.")