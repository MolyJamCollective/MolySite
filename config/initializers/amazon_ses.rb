ActionMailer::Base.add_delivery_method :ses, AWS::SES::Base, 
  access_key_id: AWS_SES_KEY_ID, 
  secret_access_key: AWS_SES_ACCESS_KEY