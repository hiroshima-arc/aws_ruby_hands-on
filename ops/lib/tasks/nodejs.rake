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

  namespace :web do
    desc 'サイト作成'
    task :create do
      cd CLI_DIR do
        sh 'npm run web:build'
      end
    end

    desc 'デプロイ'
    task :deploy do
      cd CLI_DIR do
        sh 'npm run web:deploy'
      end
    end

    desc 'サイト'
    task :site do
      cd CLI_DIR do
        sh 'npm run web:site'
      end
    end

    desc 'サイト確認'
    task :check do
      cd CLI_DIR do
        sh 'npm run web:open'
      end
    end

    desc '削除'
    task :destroy do
      cd CLI_DIR do
        sh 'npm run web:destroy'
      end
    end
  end

end