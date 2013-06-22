#!/usr/bin/env ruby
require 'cgi'

`curl -d "message=#{CGI.escape(STDIN.read)}" http://www.molyjam.com/mail_forwarder`