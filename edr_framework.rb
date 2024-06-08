class EDRFramework
  def initialize;end

  def self.run(args)
    if args.include?('-p')
      path = args[args.index('-p') + 1]
      fork do
        puts "Process started for #{path}"
      end
    end
  end
end

args = ARGV.to_ary
EDRFramework.run(args)
