# Import necessary modules
import os
import json
import logging
import boto3
from exif import Image # For reading and modifying EXIF data

logger = logging.getLogger()
logger.setLevel(logging.INFO)

s3 = boto3.client("s3")
target_bucket = os.environ.get("target_bucket_name")


def exif_remover(image_file: bytes) -> bytes:
    """Remove EXIF data from an image file.

    Parameters:
        image_file (bytes): The image file as a bytes object.

    Returns:
        bytes: The image file with the EXIF data removed.
    """

    image = Image(image_file)
    if image.has_exif:
        image.delete_all()
    return image.get_file()


def handler(event, context):
    """Lambda function handler.

    Parameters:
        event (dict): The event data.
        context (LambdaContext): The context in which the function is running.

    Returns:
        dict: The response to be sent to the client.
    """
     # Get the name of the source bucket and the key of the image object
    source_bucket = event["Records"][0]["s3"]["bucket"]["name"]
    image_object_name = event["Records"][0]["s3"]["object"]["key"]

    # Download the image object from the source bucket
    image_object: bytes = s3.get_object(
        Bucket=source_bucket, Key=image_object_name
    )["Body"].read()

    # Remove EXIF data from the image object
    image: bytes = exif_remover(image_object)

    # Upload the image object to the target bucket
    s3.put_object(Bucket=target_bucket, Key=image_object_name, Body=image)

    response_message = (
        f"exif data extracted from {image_object_name} and saved to {source_bucket}"
    )
    logger.info(response_message)
    return {
        "statusCode": 200,
        "body": json.dumps(response_message),
    }