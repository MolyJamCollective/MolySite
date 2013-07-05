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
    config.fog_directory   = fog_config["bucket"]
    #config.fog_public     = false                                   # optional, defaults to true
    #config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}

    # Carrierwave Direct Settings
    #config.validate_is_attached = true             # defaults to false
    #config.validate_is_uploaded = true             # defaults to false
    #config.validate_unique_filename = false        # defaults to true
    #config.validate_filename_format = false        # defaults to true
    #config.validate_remote_net_url_format = false  # defaults to true
    config.use_action_status = true                 # defaults to false
  
    #config.min_file_size     = 5.kilobytes         # defaults to 1.byte
    config.max_file_size     = 500.megabytes        # defaults to 5.megabytes
    #config.upload_expiration = 1.hour              # defaults to 10.hours
    #config.will_include_content_type = true        # defaults to false; if true, content-type will be set
                                                 # on s3, but you must include an input field named
                                                 # Content-Type on every direct upload form
  end

rescue StandardError
  puts "** Unable to load fog config, S3 uploading will not work until config/fog.yml is setup"
end
