module DataPipe
    
    require 'parse-cron'
    

class Job

	attr_reader :name, :next, :errorList
    
	def initialize( path )
		@path = path
		@name = File.basename( path, ".dsl" )
		@cronString = ""

		@errorList = Array.new
		self.setCron
	end

	def addError( e )
#Job Error -> Time, Exception Class Name, nsg, backtrace
		@errorList << "#{e.class.name}: #{e.message}\n#{e.backtrace.join( "\n" )}"
	end

	def clearError
		@errorList = Array.new
	end

	def runNow
		@next = Time.now - 1
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
		self.clearError
            
            rescue SystemExit, Interrupt
			raise
            rescue Exception => e
#            string = "#{e.class.name}: #{e.message}\n#{e.backtrace.join( "\n" )}"
            string = e.message
            DataPipe.log_dsl @name, string
		self.addError( e )
        end
        
		self.setCron 
		@next = @cron.next(Time.now)
	end
end

class Jobs

	attr_reader :hash, :byName
    
	def initialize
		@hash = Hash.new
		@byName = Hash.new
	end
    

    
	def call( path )
		if @hash[path].nil? then
			j = Job.new( path )
			@hash[path] = j
			@byName[j.name.downcase] = j
			j.run
            else
			@hash[path].call
		end
	end
end


end

