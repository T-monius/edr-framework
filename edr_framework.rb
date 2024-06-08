class EDRFramework
  def initialize;end

  def self.run(args)
    if args.include?('-p')
      path = args[args.index('-p') + 1]
      pid = fork do
        puts "Process started for #{path}"
      end

      Process.detach(pid)
    end
  end
end

args = ARGV.to_ary
EDRFramework.run(args)
