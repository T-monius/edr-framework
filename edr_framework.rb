class EDRFramework
  def initialize;end

  def self.run(args)
    if args.include?('-p')
      path = args[args.index('-p') + 1]
      pid = fork do
        puts "Process started for #{path}"
        f = File.open(path, 'a')
        puts "#{path} created" if File.file?(path)
        f.close
      end

      Process.detach(pid)
    end
  end
end

args = ARGV.to_ary
EDRFramework.run(args)
