require "FluidDb"


def PgsqlToPgsql( source_env_name, destination_env_name, sql, tableName, columns )
    s = DataPipe.getFluidDb( source_env_name )
    d = DataPipe.getFluidDb( destination_env_name )

    d.execute( "TRUNCATE TABLE #{tableName}", [])
    
    results = s.connection.exec( sql )
    
    d.connection.exec( "COPY #{tableName} (#{columns.join( "," )}) FROM STDIN WITH DELIMITER AS '|' CSV;" )
    
    count = results.ntuples()
    fieldCount = columns.length - 1
    0.upto( count -1 ) do |idx|
        l = Array.new
        0.upto( fieldCount ).each do |jdx|
            l << results.getvalue(idx, jdx)
        end
        d.connection.put_copy_data "#{l.join( '|' )}\n"
    end
    d.connection.put_copy_end
    
    DataPipe.log "#{tableName}: #{count}", true
end

