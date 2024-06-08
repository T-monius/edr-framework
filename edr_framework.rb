class EDRFramework
  def initialize;end

  def self.run
    fork do
      puts "Process started"
    end
  end
end

EDRFramework.run
