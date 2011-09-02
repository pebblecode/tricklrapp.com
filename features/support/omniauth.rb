Before('@omniauth_twitter') do
  OmniAuth.config.test_mode = true
  OmniAuth.config.add_mock(:twitter, { 
    :provider    => "twitter", 
    :uid         => "36670724", 
    :user_info   => { 
    :name       => "George Ornbo", 
    :nickname   => "shapeshed"
    }, 
    :credentials => {   
      :token => "36670724-itwLyz641g76JitN9CTIpEw5Dtrsa7NLU7fpZ7aPXO",
      :secret => "OcKQ907H0KUV7qzbWNGNYasdEBDsjasd5rPXtyTzi6c"
    } 
  })
end
    
After('@omniauth_twitter') do
  OmniAuth.config.test_mode = false
end
