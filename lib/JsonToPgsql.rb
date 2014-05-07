require "FluidDb"
require "json"


def JsonToPgsql( source_env_name, destination_env_name, tableName, columns )
    d = DataPipe.getFluidDb( destination_env_name )

    d.execute( "TRUNCATE TABLE #{tableName}", [])
    
    results = s.connection.exec( sql )
    
    d.connection.exec( "COPY #{tableName} (#{columns.join( "," )}) FROM STDIN WITH DELIMITER AS '|' CSV;" )
    
    JSON.parse( IO.read( DataPipe.getEnvVar( source_env_name ) ) ).each do |row|
        l = Array.new
	columns.each do |name|
            l << row[name]
        end
        d.connection.put_copy_data "#{l.join( '|' )}\n"
    end
    d.connection.put_copy_end
    
    DataPipe.log "#{tableName}: #{count}", true
end

