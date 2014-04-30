module DataPipe

def DataPipe.log( string, verbose=false )
        type = verbose ? "VERB" : "INFO"
        if !ENV["VERBOSE"].nil? || !verbose then
            timestamp = Time.new.strftime( "%Y-%m-%d %H:%M:%S" )
            puts "[#{type}] #{timestamp} :: #{string}"
        end
end


def DataPipe.log_dsl( name, string, verbose=false )
	log "name: #{name}, #{string}", verbose
end


def DataPipe.getEnvVar( name )
	raise EnvironmentVariableNotFoundError.new( name ) if ENV[name].nil?

	return ENV[name]
end


def DataPipe.getFluidDb( env_name )
	e = "_#{env_name}"

	uri_string = getEnvVar(env_name)
	log "uri: #{uri_string}", true
	return FluidDb::Db( uri_string )

end

end

