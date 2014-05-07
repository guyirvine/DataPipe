require 'rubygems'
require 'rack'
require 'thin'


module DataPipe

    class Host

	attr_accessor :hash
        
        def run

            libs = ENV["LIB"] ||= "./lib"
            dsl_paths = ENV["DSL"] ||= "./dsl"
puts "dsl_paths: #{dsl_paths}"            
            
            libs.split( ";" ).each do |path|
                DataPipe.log "Adding libdir: #{path}"
                $:.unshift path
            end                
                loop = true
                
                
                jobs = Jobs.new
		@hash['jobs'] = jobs
                while loop do
                    begin
                        dsl_paths.split( ";" ).each do |dsl_dir|
                            Dir.glob( "#{dsl_dir}/*.dsl" ).each do |dsl_path|
                                jobs.call dsl_path
                                
                            end
                        end
                        
                        sleep 0.5
                        rescue SystemExit, Interrupt
                        puts "Exiting on request ..."
                        loop = false
                    end
                end
                

        end
        
    end
    
end

