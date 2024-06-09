require 'logger'
require 'socket'
require 'yaml'

class EDRFramework
  def initialize;end

  def self.run(args, lgr)
    pid = fork do
      process_info = {:operation => 'process started', :username => ENV['USER'], :cmd_line => ENV['SHELL'].split('/').last }
      lgr.info {  process_info.to_yaml }
      if args.include?('-p')
        path = args[args.index('-p') + 1]
        if args.include?('-d')
          File.delete("edr-files/#{path}") if File.file?("edr-files/#{path}")
        elsif args.include?('-c')
          File.open("edr-files/#{path}", 'w')
          puts "#{path} created" if File.file?("edr-files/#{path}")
        elsif args.include?('-u')
          File.open("edr-files/#{path}", 'a') do |f|
            f.write("some network data\n")
          end
          puts "#{path} modified" if File.file?("edr-files/#{path}")
        end
      elsif args.include?('-n')
        host = args[args.index('-n') + 1]
        port = args[args.index('-n') + 2]
        data = args[args.index('-n') + 3]
        client = TCPSocket.open(host, port)

        client.puts data
        client.close
      end
    end
    Process.detach(pid)
  end
end

args = ARGV.to_ary
logger = Logger.new('logs/edr_framework_log.yaml', level: Logger::INFO)
EDRFramework.run(args, logger)
