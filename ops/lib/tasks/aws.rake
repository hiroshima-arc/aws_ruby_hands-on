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
end
