root = File.dirname(__FILE__)
WORK = "#{root}/../../.."

# aws
LOCAL_DB = 'dynamodb'
LOCAL_NETWORK = 'lambda-local'

# sam
APP_DIR = "#{WORK}/dev/sam-app".freeze
APP_S3_BUCKET = 'ruby-hands-on'
APP_STACK_NAME  = 'ruby-hands-on-development'

CLI_DIR = "#{WORK}/dev/sam-client".freeze
CLI_S3_BUCKET = 'ruby-hands-on'
CLI_STACK_NAME  = 'ruby-hands-on-client-development'
