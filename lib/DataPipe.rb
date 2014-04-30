#Don't buffer stdout
$stdout.sync = true

module DataPipe
    
    require 'helper_functions'
    require 'Jobs'
    require 'Host'
    
    
    class DataPipelineError<StandardError
    end
    class EnvironmentVariableNotFoundError<DataPipelineError
    end
    
    
end


