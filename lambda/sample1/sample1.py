import json
import requests


def lambda_handler(event, context):
    return {
        "statusCode": 200,
        "body": "{\"message\":\"Sample lambda function.\"}"
    }
