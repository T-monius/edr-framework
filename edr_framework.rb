require 'logger'
require 'socket'
require 'yaml'

class EDRFramework
  def initialize;end

  def self.run(args, lgr)
    pid = fork do
      process_info = {:username => ENV['USER'], :cmd_line => ENV['SHELL'].split('/').last }
      lgr.info {  process_info.to_yaml }
      if args.include?('-p')
        path = args[args.index('-p') + 1]
        edr_file_dir = "edr-files"
        new_path = "#{edr_file_dir}/#{path}"
        dir_realpath = File.realpath(edr_file_dir)
        full_path = "#{dir_realpath}/#{path}"
        file_op_info = { full_path: dir_realpath, process_name: $PROGRAM_NAME }
        if args.include?('-d')
          File.delete("edr-files/#{path}") if File.file?("edr-files/#{path}")
          file_op_info[:full_path] = full_path
          file_op_info[:activity_descriptor] = 'delete'
          lgr.info {  process_info.merge(file_op_info).to_yaml }
        elsif args.include?('-c')
          File.open(new_path, 'w')
          file_op_info[:full_path] = full_path
          file_op_info[:activity_descriptor] = 'create'
          lgr.info {  process_info.merge(file_op_info).to_yaml }
        elsif args.include?('-u')
          data = args[args.index('-p') + 2]
          File.open("edr-files/#{path}", 'a') do |f|
            f.write("#{data}\n")
          end
          file_op_info[:full_path] = full_path
          file_op_info[:activity_descriptor] = 'modified'
          lgr.info {  process_info.merge(file_op_info).to_yaml }
        end
      elsif args.include?('-n')
        host = args[args.index('-n') + 1]
        port = args[args.index('-n') + 2]
        data = args[args.index('-n') + 3]
        client = TCPSocket.open(host, port)
        network_op_info = { activity_descriptor: 'transmitted data', destination_address: host, destination_port: port, data_bytes: data.bytesize, protocol: "tcp", process_name: $PROGRAM_NAME }

        client.puts data
        client.close

        lgr.info {  process_info.merge(network_op_info).to_yaml }
      end
    end
    Process.detach(pid)
  end
end

args = ARGV.to_ary
logger = Logger.new('logs/edr_framework_log.yaml', level: Logger::INFO)
EDRFramework.run(args, logger)
