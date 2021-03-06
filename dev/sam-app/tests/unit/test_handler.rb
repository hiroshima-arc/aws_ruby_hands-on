# frozen_string_literal: true

require 'json'
require 'test/unit'
require 'mocha/test_unit'
require 'simplecov'
SimpleCov.start
require_relative '../../hello_world/app'

class HelloWorldTest < Test::Unit::TestCase
  def setup
    @event = {
      body: 'eyJ0ZXN0IjoiYm9keSJ9',
      resource: '/{proxy+}',
      path: '/path/to/resource',
      httpMethod: 'POST',
      isBase64Encoded: true,
      queryStringParameters: {
        foo: 'bar'
      },
      pathParameters: {
        proxy: '/path/to/resource'
      },
      stageVariables: {
        baz: 'qux'
      },
      headers: {
        Accept: 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
        'Accept-Encoding': 'gzip, deflate, sdch',
        'Accept-Language': 'en-US,en;q=0.8',
        'Cache-Control': 'max-age=0',
        'CloudFront-Forwarded-Proto': 'https',
        'CloudFront-Is-Desktop-Viewer': 'true',
        'CloudFront-Is-Mobile-Viewer': 'false',
        'CloudFront-Is-SmartTV-Viewer': 'false',
        'CloudFront-Is-Tablet-Viewer': 'false',
        'CloudFront-Viewer-Country': 'US',
        Host: '1234567890.execute-api.us-east-1.amazonaws.com',
        'Upgrade-Insecure-Requests': '1',
        'User-Agent': 'Custom User Agent String',
        Via: '1.1 08f323deadbeefa7af34d5feb414ce27.cloudfront.net (CloudFront)',
        'X-Amz-Cf-Id': 'cDehVQoZnx43VYQb9j2-nvCh-9z396Uhbp027Y2JvkCPNLmGJHqlaA==',
        'X-Forwarded-For': '127.0.0.1, 127.0.0.2',
        'X-Forwarded-Port': '443',
        'X-Forwarded-Proto': 'https'
      },
      requestContext: {
        accountId: '123456789012',
        resourceId: '123456',
        stage: 'prod',
        requestId: 'c6af9ac6-7b61-11e6-9a41-93e8deadbeef',
        requestTime: '09/Apr/2015:12:34:56 +0000',
        requestTimeEpoch: 1_428_582_896_000,
        identity: {
          cognitoIdentityPoolId: 'null',
          accountId: 'null',
          cognitoIdentityId: 'null',
          caller: 'null',
          accessKey: 'null',
          sourceIp: '127.0.0.1',
          cognitoAuthenticationType: 'null',
          cognitoAuthenticationProvider: 'null',
          userArn: 'null',
          userAgent: 'Custom User Agent String',
          user: 'null'
        },
        path: '/prod/path/to/resource',
        resourcePath: '/{proxy+}',
        httpMethod: 'POST',
        apiId: '1234567890',
        protocol: 'HTTP/1.1'
      }
    }

    @mock_response = {
      statusCode: 200,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: {
        message: 'Hello World!',
        location: '1.1.1.1'
      }.to_json
    }
  end

  def test_lambda_handler
    expects(:lambda_handler).with(event: @event, context: '').returns(@mock_response)
    response = lambda_handler(event: @event, context: '')
    json_body = JSON.parse(response[:body])

    assert_equal(200, response[:statusCode])
    assert_equal('Hello World!', json_body['message'])
    assert_equal('1.1.1.1', json_body['location'])
  end
end
