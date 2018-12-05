namespace :test do
  namespace :app do
    APP_TEST_DIR = 'dev/sam-app'

    desc 'コードチェック'
    task :lint do
      cd APP_TEST_DIR do
        sh "rubocop -a hello_world/app.rb"
        sh "rubocop -a tests/unit/test_handler.rb"
        sh "rubocop -a tests/unit/**/*.rb"
      end
    end

    desc 'ユニットテスト'
    task :unit do
      cd APP_TEST_DIR do
        sh "ruby tests/unit/*.rb"
        sh "ruby tests/unit/**/test_*.rb"
        sh "ruby tests/unit/**/*_test.rb"
      end
    end

    desc 'Test all task'
    task all: %i[lint unit]
  end

  namespace :client do
    CLI_TEST_DIR = 'dev/sam-client'

    desc 'コードチェック'
    task :lint do
      cd CLI_TEST_DIR do
        sh "rubocop -a hello_world/app.rb"
        sh "rubocop -a tests/unit/test_handler.rb"
      end
    end

    desc 'ユニットテスト'
    task :unit do
      cd CLI_TEST_DIR do
        sh "ruby tests/unit/*.rb"
        sh "ruby tests/unit/**/test_*.rb"
      end
    end

    desc 'Test all task'
    task all: %i[lint unit]
  end
end