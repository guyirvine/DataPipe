require 'StreamBuilder'


def DbToDir( db_env_name, sql, splitField, path, prefix )
#    Dir.mkdir( path ) unless Dir.exists?( path )

    db = DataPipe.getFluidDb( db_env_name )

    hash = Hash.new
    rst = db.queryForResultset( sql, [] )
    columns = rst[0].keys if rst.length > 0


    rst.each do |r|
        hash[r[splitField]] = Array.new unless hash.has_key?(r[splitField])

        hash[r[splitField]] << r
    end

    basePath = "#{path}/#{prefix}-"
    Dir.glob( "#{basePath}*" ).each { |f| File.delete(f) }

    hash.each do |k,v|
        s = StreamBuilder.new
                .f( columns )
	v.each { |r| s.add *r.values }
        File.write( "#{basePath}#{k}.js", s.serialize )
    end

    return hash
end

