require 'net/sftp'
require 'uri'


def PathFromRemote( remoteUri, localPath, prefix )

	uri = URI.parse( remoteUri )
        DataPipe.log "remoteUri: #{remoteUri}, localPath: #{localPath}, prefix: #{prefix}", true

        Net::SFTP.start( uri.host, uri.user, :password => uri.password ) do |sftp|
                Dir.glob( "#{localPath}/#{prefix}*" ).each do |path|
                        File.rm( path )
                end     

		sftp.dir.foreach(uri.path) do |entry|
			name = entry.name
			if name[0,prefix.length] == prefix && entry.file? then
				DataPipe.log "sftp.rm: #{uri.path}/#{name}"
				sftp.download!( "#{uri.path}/#{name}" ) if name[0,prefix.length] == prefix && entry.file?
				sftp.remove!( "#{uri.path}/#{name}" ) if name[0,prefix.length] == prefix && entry.file?
			end
		end

        end

end

