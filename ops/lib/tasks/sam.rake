namespace :sam do
  WORK_DIR = 'sam-app'

  desc 'ローカル実行'
  task :local_invoke do
    cd WORK_DIR do
      sh 'sam local invoke HelloWorldFunction --event tests/hello_world/event_file.json'
    end
  end

  desc 'ローカルサーバー実行'
  task :local_api do
    cd WORK_DIR do
      sh 'sam local start-api --host 0.0.0.0'
    end
  end

  desc 'チェック'
  task :validate do
    cd WORK_DIR do
      sh 'sam validate'
    end
  end

  desc 'パッケージ'
  task :package do
    cd WORK_DIR do
      sh 'sam package --template-file template.yaml --s3-bucket ruby-hands-on --output-template-file packaged.yaml'
    end
  end

  desc 'デプロイ'
  task :deploy do
    cd WORK_DIR do
      sh 'sam deploy --template-file packaged.yaml --stack-name ruby-hands-on-development --capabilities CAPABILITY_IAM'
    end
  end

  desc '確認'
  task :check do
    cd WORK_DIR do
      sh "aws cloudformation describe-stacks --stack-name ruby-hands-on-development --query 'Stacks[].Outputs[1]'"
    end
  end

  desc 'リリース'
  task release: %i[validate package deploy check]
end
