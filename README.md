# pwa
Turned https://aws.amazon.com/getting-started/hands-on/build-serverless-web-app-lambda-apigateway-s3-dynamodb-cognito/ into a terraform repo

To redeploy:
1. Update bucket name
2. Terraform apply
3. Open Cognito and copy the PoolId and ClientId into static/js/config.js
4. Open API Gateway and get the invokeUrl and put it in static/js/config.js

