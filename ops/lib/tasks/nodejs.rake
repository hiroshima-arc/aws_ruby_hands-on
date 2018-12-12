namespace :nodejs do
  desc '開発サーバー'
  task :local do
    cd CLI_DIR do
      sh 'npm start'
    end
  end

  desc 'ビルド'
  task :build do
    cd CLI_DIR do
      sh 'npm run build'
    end
  end
end