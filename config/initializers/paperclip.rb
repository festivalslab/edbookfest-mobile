# Config for paperclip (for festival branding themes)
Paperclip::Attachment.default_options[:storage] = :s3
Paperclip::Attachment.default_options[:s3_credentials] = {:access_key_id => ENV['EIBF_S3_ACCESSKEY'], :secret_access_key => ENV['EIBF_S3_SECRET']}
Paperclip::Attachment.default_options[:bucket] = ENV['EIBF_S3_BUCKET']
Paperclip::Attachment.default_options[:s3_host_name] = :ENV['EIBF_S3_HOST']
Paperclip::Attachment.default_options[:hash_secret] = ENV['EIBF_HASH_SECRET']
