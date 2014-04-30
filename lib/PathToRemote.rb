require 'net/sftp'
require 'uri'


def PathToRemote( sourcePath, remoteUri, prefix )

	uri = URI.parse( remoteUri )
        DataPipe.log "sourcePath: #{sourcePath}, remoteUri: #{remoteUri}, prefix: #{prefix}", true

        Net::SFTP.start( uri.host, uri.user, :password => uri.password ) do |sftp|
		sftp.dir.foreach(uri.path) do |entry|
			name = entry.name
			if name[0,prefix.length] == prefix && entry.file? then
				DataPipe.log "sftp.rm: #{uri.path}/#{name}"
				sftp.remove!( "#{uri.path}/#{name}" ) if name[0,prefix.length] == prefix && entry.file?
			end
		end

		Dir.glob( "#{sourcePath}/#{prefix}*" ).each do |path|
                        sftp.upload!( path, "#{uri.path}/#{File.basename( path )}" )
		end
        end

end

