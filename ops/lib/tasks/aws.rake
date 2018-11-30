namespace :aws do
  BUILD_SH = './ops/aws/code_build/aws-codebuild-docker-images/local_builds/codebuild_build.sh'

  namespace :code_build do
    desc 'CodeBiuldローカル実行'
    task :local do
      sh "#{BUILD_SH} -i aws/codebuild/ruby:2.5.1 -a ./ops/aws/code_build/artifact"
    end
  end
end
