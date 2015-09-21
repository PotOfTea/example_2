name             "webservice"
maintainer       "rs"
maintainer_email "rs"
license          "All rights reserved"
description      "Installs/Configures cookbook-webservice"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

recipe "webservice", "Installs webservice"
recipe "webservice::jmxetric", "Installs jmxetric for ganglia"