namespace :test do
  WORK_DIR = 'sam-app'

  desc 'コードチェック'
  task :lint do
    cd WORK_DIR do
      sh "rubocop -a hello_world/app.rb"
      sh "rubocop -a tests/unit/test_handler.rb"
    end
  end

  desc 'ユニットテスト'
  task :unit do
    cd WORK_DIR do
      sh "ruby tests/unit/*.rb"
    end
  end

  desc 'Test all task'
  task all: %i[lint unit]
end