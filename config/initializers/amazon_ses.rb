begin
  fog_config = YAML.load_file("#{Rails.root}/config/fog.yml")["fog"]

  ActionMailer::Base.add_delivery_method :ses, AWS::SES::Base, 
    access_key_id: fog_config["aws_access_key_id"], 
    secret_access_key: fog_config["aws_secret_access_key"]

rescue StandardError
  puts "** Unable to load fog config, SES sending will not work until config/fog.yml is setup"
end