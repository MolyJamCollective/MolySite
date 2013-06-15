begin
  fog_config = YAML.load_file("#{Rails.root}/config/fog.yml")["fog"]

  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider:               fog_config["provider"],
      aws_access_key_id:      fog_config["aws_access_key_id"],
      aws_secret_access_key:  fog_config["aws_secret_access_key"],
      #region:                'eu-west-1',                  # optional, defaults to 'us-east-1'
      #host:                  's3.example.com',             # optional, defaults to nil
      #endpoint:              'https://s3.example.com:8080' # optional, defaults to nil
    }
    config.fog_directory  = "#{fog_config["bucket"]}/uploads"
    #config.fog_public     = false                                   # optional, defaults to true
    #config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
  end

rescue StandardError
  puts "** Unable to load fog config, S3 uploading will not work until config/fog.yml is setup"
end