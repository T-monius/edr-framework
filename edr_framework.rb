require 'socket'

class EDRFramework
  def initialize;end

  def self.run(args)
    pid = fork do
      puts "Process started"
      if args.include?('-p')
        path = args[args.index('-p') + 1]
        if args.include?('-d')
          File.delete("edr-files/#{path}") if File.file?("edr-files/#{path}")
        else
          File.open("edr-files/#{path}", 'a') do |f|
            f.write("some network data\n")
          end
          puts "#{path} created/modified" if File.file?("edr-files/#{path}")
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
EDRFramework.run(args)
