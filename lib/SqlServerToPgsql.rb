
def SqlServerToPgsql( s_s, d_s, sql, tableName, columns )
    s = FluidDb::Db( ENV[s_s] )
    d = FluidDb::Db( ENV[d_s] )

    d.connection.exec( "TRUNCATE TABLE #{tableName}")
    d.connection.exec( "COPY #{tableName} (#{columns.join( "," )}) FROM STDIN WITH DELIMITER AS '|' CSV;" )

        results = @SourceDb.connection.execute( sql )

        count = 0
        results.each(:as => :array, :cache_rows => false) do |r|
            count = count + 1
            @Pgsql.connection.put_copy_data "#{r.join( '|' )}\n"
    end
    d.connection.put_copy_end
    
    RServiceBus.log "#{tableName}: #{count}"
end

