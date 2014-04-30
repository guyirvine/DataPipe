#!/usr/bin/env ruby
module DataPipe
    
    require 'helper_functions'
    require 'Jobs'
    require 'Host'
    
    
    class DataPipelineError<StandardError
    end
    class EnvironmentVariableNotFoundError<DataPipelineError
    end
    
    
end


