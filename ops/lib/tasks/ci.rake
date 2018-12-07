namespace :ci do
  BUILD_SH = './ops/aws/code_build/aws-codebuild-docker-images/local_builds/codebuild_build.sh'
  REPOSITORY = 'hiroshimaarc'
  CI_IMAGE = 'aws-ruby-hands-on'
  IMAGE_VER = '1.0.0'

  desc 'CIイメージのビルド'
  task :build_image do
    cd "#{WORK}/ops/aws/code_build/aws-codebuild-docker-images/ubuntu/ruby/2.5.3" do
      sh "docker build -t #{CI_IMAGE}-base ."
    end
    cd "#{WORK}/ops/docker/repo" do
      sh "docker build -t #{CI_IMAGE} ."
    end
  end

  desc 'CIイメージのバージョン更新'
  task :update_image, [:ver] => [:build_image] do |_t, args|
    sh "docker tag re-zero-tdd:latest #{REPOSITORY}/#{CI_IMAGE}:#{args[:ver]}"
  end

  desc 'CIイメージのデプロイ'
  task :deploy_image, [:ver] do |_t, args|
    sh "docker push #{REPOSITORY}/#{CI_IMAGE}:#{args[:ver]}"
  end

  desc 'CIのローカル実行'
  task :local do
    sh "#{BUILD_SH} -i #{REPOSITORY}/#{CI_IMAGE}:#{IMAGE_VER} -a #{WORK}/ops/aws/code_build/artifact"
  end

  desc 'CIイメージ内シェル'
  task :shell do
    sh "docker run -v $(PWD):/repo -it --entrypoint sh #{REPOSITORY}/#{CI_IMAGE}:#{IMAGE_VER} -c bash"
  end
end
