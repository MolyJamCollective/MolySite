#!/usr/bin/env ruby
require 'cgi'

`curl -d "message=#{CGI.escape(STDIN.read)}" http://localhost/mail_forwarder`