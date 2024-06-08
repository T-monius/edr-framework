class EDRFramework
  def initialize;end

  def self.run(args)
    if args.include?('-p')
      path = args[args.index('-p') + 1]
      pid = fork do
        puts "Process started for #{path}"
        File.open("edr-files/#{path}", 'a') do |f|
          f.write("some network data\n")
        end
        puts "#{path} created/modified" if File.file?(path)
      end

      Process.detach(pid)
    end
  end
end

args = ARGV.to_ary
EDRFramework.run(args)
