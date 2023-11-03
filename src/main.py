import boto3
import botocore.exceptions
import argparse

def upload_file(local_file, bucket_name, remote_name):
    """
    Use the AWS SDK for Python (Boto3) to create an Amazon Simple Storage Service
    (Amazon S3) resource and list the buckets in your account.
    This example uses the default settings specified in your shared credentials
    and config files.
    """
    s3 = boto3.resource("s3")
    try:
        s3.create_bucket(Bucket=bucket_name)
    except s3.meta.client.exceptions.BucketAlreadyExists:
        pass
    except s3.meta.client.exceptions.BucketAlreadyOwnedByYou:
        pass
    s3.Bucket(bucket_name).upload_file(local_file, remote_name)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
                    prog='s3upload',
                    description='Upload a file to s3')
    parser.add_argument("local_file")
    parser.add_argument("bucket_name")
    parser.add_argument("remote_name")

    args = parser.parse_args()

    upload_file(args.local_file, args.bucket_name, args.remote_name)
