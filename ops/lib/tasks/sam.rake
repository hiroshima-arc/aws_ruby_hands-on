namespace :sam do
  namespace :app do
    APP_DIR = "#{WORK}/dev/sam-app".freeze
    APP_S3_BUCKET = 'ruby-hands-on'
    APP_STACK_NAME  = 'ruby-hands-on-development'

    namespace :local do
      desc 'ローカルサーバー実行'
      task :api do
        cd APP_DIR do
          sh 'sam local start-api --host 0.0.0.0'
        end
      end

      desc 'ローカル実行'
      task invoke: %i[hellow_world:hello fizz_buzz:generate fizz_buzz:iterate]
      namespace :hellow_world do
        task :hello do
          cd APP_DIR do
            sh 'sam local invoke HelloWorldFunction --event tests/hello_world/event_file.json'
          end
        end
      end

      namespace :fizz_buzz do
        task :generate do
          cd APP_DIR do
            sh 'sam local invoke FizzBuzzGenerateFunction --event tests/fizz_buzz/event_file.json'
          end
        end

        task :iterate do
          cd APP_DIR do
            sh 'sam local invoke FizzBuzzIterateFunction --event tests/fizz_buzz/event_file.json'
          end
        end
      end
    end

    desc 'チェック'
    task :validate do
      cd APP_DIR do
        sh 'sam validate'
      end
    end

    desc 'アプリケーションパッケージバンドル'
    task :vendor do
      cd APP_DIR do
        FileUtils.rm_rf('hello_world/vendor/')
        FileUtils.rm_rf('fizz_buzz/vendor/')
        sh 'bundle install --path hello_world/vendor/bundle'
        sh 'bundle install --path fizz_buzz/vendor/bundle'
      end
    end

    desc 'パッケージ'
    task :package do
      cd APP_DIR do
        sh "sam package --template-file template.yaml --s3-bucket #{APP_S3_BUCKET} --output-template-file packaged.yaml"
      end
    end

    desc 'デプロイ'
    task :deploy do
      cd APP_DIR do
        sh "sam deploy --template-file packaged.yaml --stack-name #{APP_STACK_NAME} --capabilities CAPABILITY_IAM"
      end
    end

    desc '確認'
    task :check do
      cd APP_DIR do
        sh "aws cloudformation describe-stacks --stack-name #{APP_STACK_NAME} --query 'Stacks[].Outputs[1]'"
      end
    end

    desc '削除'
    task :destroy do
      cd APP_DIR do
        sh "aws cloudformation delete-stack --stack-name #{APP_STACK_NAME}"
      end
    end

    desc 'リリース'
    task release: %i[validate package deploy check]

    desc 'クリーンリリース'
    task clean_release: %i[vendor validate package deploy check]
  end

  namespace :client do
    CLI_DIR = "#{WORK}/dev/sam-client".freeze
    CLI_S3_BUCKET = 'ruby-hands-on'
    CLI_STACK_NAME  = 'ruby-hands-on-client-development'

    namespace :local do
      desc 'ローカルサーバー実行'
      task :api do
        cd CLI_DIR do
          sh 'sam local start-api --host 0.0.0.0'
        end
      end

      desc 'ローカル実行'
      task invoke: %i[hellow_world:hello]
      namespace :hellow_world do
        task :hello do
          cd CLI_DIR do
            sh 'sam local invoke HelloWorldFunction --event services/tests/hello_world/event_file.json'
          end
        end
      end
    end

    desc 'チェック'
    task :validate do
      cd CLI_DIR do
        sh 'sam validate'
      end
    end

    desc 'アプリケーションパッケージバンドル'
    task :vendor do
      cd CLI_DIR do
        FileUtils.rm_rf('vendor/')
        sh 'bundle install --path vendor/bundle'
        FileUtils.rm_rf('services/hello_world/vendor/')
        sh 'cd services ; bundle install --path hello_world/vendor/bundle'
        sh 'npx webpack --mode=production'
      end
    end

    desc 'パッケージ'
    task :package do
      cd CLI_DIR do
        sh "sam package --template-file template.yaml --s3-bucket #{CLI_S3_BUCKET} --output-template-file packaged.yaml"
      end
    end

    desc 'デプロイ'
    task :deploy do
      cd CLI_DIR do
        sh "sam deploy --template-file packaged.yaml --stack-name #{CLI_STACK_NAME} --capabilities CAPABILITY_IAM"
      end
    end

    desc '確認'
    task :check do
      cd CLI_DIR do
        sh "aws cloudformation describe-stacks --stack-name #{CLI_STACK_NAME} --query 'Stacks[].Outputs[1]'"
      end
    end

    desc '削除'
    task :destroy do
      cd CLI_DIR do
        sh "aws cloudformation delete-stack --stack-name #{CLI_STACK_NAME}"
      end
    end

    desc 'リリース'
    task release: %i[validate package deploy check]

    desc 'クリーンリリース'
    task clean_release: %i[vendor validate package deploy check]
  end

  namespace :staging do
    STG_DIR = "#{WORK}/dev".freeze
    STG_S3_BUCKET = 'ruby-hands-on'
    STG_STACK_NAME  = 'ruby-hands-on-staging'

    task :validate do
      cd STG_DIR do
        sh 'sam validate'
      end
    end

    task :package do
      cd STG_DIR do
        sh "sam package --template-file template.yaml --s3-bucket #{STG_S3_BUCKET} --output-template-file packaged.yaml"
      end
    end

    task :deploy do
      cd STG_DIR do
        sh "sam deploy --template-file packaged.yaml --stack-name #{STG_STACK_NAME} --capabilities CAPABILITY_IAM"
      end
    end

    task :check do
      cd STG_DIR do
        sh "aws cloudformation describe-stacks --stack-name #{STG_STACK_NAME} --query 'Stacks[].Outputs[1]'"
      end
    end

    desc '削除'
    task :destroy do
      cd STG_DIR do
        sh "aws cloudformation delete-stack --stack-name #{STG_STACK_NAME}"
      end
    end

    desc 'リリース'
    task release: %i[validate package deploy check]
  end

  namespace :production do
    PRD_DIR = "#{WORK}/dev".freeze
    PRD_S3_BUCKET = 'ruby-hands-on'
    PRD_STACK_NAME  = 'ruby-hands-on-production'

    desc '確認'
    task :check do
      cd STG_DIR do
        sh "aws cloudformation describe-stacks --stack-name #{PRD_STACK_NAME} --query 'Stacks[].Outputs[1]'"
      end
    end
  end
end
