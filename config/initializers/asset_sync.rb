begin
  fog_config = YAML.load_file("#{Rails.root}/config/fog.yml")["fog"]

  AssetSync.configure do |config|
    config.fog_provider           = fog_config["provider"]
    config.aws_access_key_id      = fog_config["aws_access_key_id"]
    config.aws_secret_access_key  = fog_config["aws_secret_access_key"]
    config.fog_directory          = fog_config["bucket"]
    
    # store assets in a 'folder' instead of bucket root
    config.assets.prefix = "/assets"
  
    # Increase upload performance by configuring your region
    # config.fog_region = 'eu-west-1'
  
    # Don't delete files from the store
    config.existing_remote_files = "delete"
  
    # Automatically replace files with their equivalent gzip compressed version
    config.gzip_compression = true
  
    # Use the Rails generated 'manifest.yml' file to produce the list of files to 
    # upload instead of searching the assets directory.
    config.manifest = false
  
    # Fail silently.  Useful for environments such as Heroku
    config.fail_silently = false
  end

rescue StandardError
  puts "** Unable to load fog config, S3 uploading will not work until config/fog.yml is setup"
end
