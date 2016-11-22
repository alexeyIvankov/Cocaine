

Pod::Spec.new do |s|


  s.name         = "Cocaine"
  s.version      = "1.0.0"
  s.summary      = "Cocaine framework"
  s.description  = "Cocaine framework"
  s.homepage     = "http://EXAMPLE/Cocaine"
  s.license      = "Cocaine"
  s.author       = { "Ivankov Alexey" => "" }


	s.ios.deployment_target = "8.0"
	s.osx.deployment_target = "10.7"
	s.watchos.deployment_target = "2.0"
	s.tvos.deployment_target = "9.0"


  s.source       = { :git => 'https://github.com/alexeyIvankov/Cocaine.git', :branch => 'master'  }

  s.source_files  = "Cocaine/**/*.{swift, h}"
  s.xcconfig= {"HEADER_SEARCH_PATHS" => '$(PODS_ROOT)/Cocaine'}


end
