module DataPipe
    
    require 'parse-cron'
    

class Job
    
	def initialize( path )
		@path = path
		@name = File.basename( path, ".dsl" )
		@cronString = ""
		self.setCron
	end

	def setCron
		tmp = ENV["#{@name}_CRON"] ||= "0 0 * * *"
		return if tmp == @cronString

                @cronString = tmp
                @cron = CronParser.new(@cronString)
	end
    
	def call
		self.run if Time.now > @next
	end
    
	def run
        begin
			DataPipe.log "path: #{@path}", true
			DataPipe.log "dsl: #{@name}"
            load @path
            
            rescue SystemExit, Interrupt
			raise
            rescue Exception => e
            string = "#{e.class.name}: #{e.message}\n#{e.backtrace.join( "\n" )}"
            DataPipe.log_dsl @name, string
        end
        
		self.setCron 
		@next = @cron.next(Time.now)
	end
end

class Jobs
    
	def initialize
		@hash = Hash.new
	end
    
    
	def call( path )
		if @hash[path].nil? then
			j = Job.new( path )
			@hash[path] = j
			j.run
            else
			@hash[path].call
		end
	end
end


end

