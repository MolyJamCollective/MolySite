begin
  fog_config = YAML.load_file("#{Rails.root}/config/fog.yml")["fog"]

  CarrierWave.configure do |config|
    config.fog_credentials = {
      :provider               => fog_config["provider"],
      :aws_access_key_id      => fog_config["aws_access_key_id"],
      :aws_secret_access_key  => fog_config["aws_secret_access_key"]
    }
    config.fog_directory = fog_config["bucket"]
  end

rescue StandardError
  puts "** Unable to load fog config, S3 uploading will not work until config/fog.yml is setup"
end
