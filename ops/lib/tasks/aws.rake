namespace :aws do
  namespace :code_pipeline do
    desc 'パイプライン作成'
    task :build do
      cd "#{WORK}/ops/aws/code_pipeline" do
        sh "./create_stack.sh"
      end
    end

    desc 'パイプライン更新'
    task :update do
      cd "#{WORK}/ops/aws/code_pipeline" do
        sh "./update_stack.sh"
      end
    end

    desc 'パイプライン削除'
    task :destroy do
      cd "#{WORK}/ops/aws/code_pipeline" do
        sh "./destroy_stack.sh"
      end
    end
  end

  namespace :dynamodb do
    namespace :local do
      desc 'セットアップ'
      task :setup do
        sh "docker network create #{LOCAL_NETWORK}"
        sh "docker run -d -v \"$PWD\":/dynamodb_local_db -p 8000:8000 --network #{LOCAL_NETWORK} --name #{LOCAL_DB} instructure/dynamo-local-admin"
      end

      desc '起動'
      task :start do
        sh "docker start #{LOCAL_DB}"
      end

      desc 'URL表示'
      task :show do
        sh "http://127.0.0.1:8000"
      end

      desc '停止'
      task :stop do
        sh "docker stop #{LOCAL_DB}"
      end

      desc '削除'
      task :destroy do
        sh "docker network rm #{LOCAL_NETWORK}"
        sh "docker rm #{LOCAL_DB}"
      end
    end
  end
end
