require 'rubygems'
require 'rack'
require 'json'


module DataPipe
    
    class WWW
        
        attr_accessor :hash
        
        def call(env)
            @root = File.expand_path(File.dirname(__FILE__))
            path = Rack::Utils.unescape(env['PATH_INFO'])
#            path += 'index.html' if path == '/'
            file = @root + "#{path}"
            
            params = Rack::Utils.parse_nested_query(env['QUERY_STRING'])

            request = Rack::Request.new(env)
            response = Rack::Response.new()
	parts = request.path_info.downcase.split( "/" )
	section = parts[1]
	case true
		when request.request_method == "GET" && request.path_info.downcase == "/" then
			l = ['jobs', 'errors']
            [ 200, {'Content-Type' => 'application/json'}, l.to_json ]
			
		when request.request_method == "GET" && section == "jobs" && parts.length == 2 then
		l = Array.new
		@hash['jobs'].hash.each do |k,job|
			l << Hash['name',job.name,'next',job.next,'errors',job.errorList.length]
			end
            [ 200, {'Content-Type' => 'application/json'}, l.to_json ]



                when request.request_method == "GET" && section == "jobs" && parts.length == 3 then
			jobName = parts[2]
			[404, {'Content-Type' => 'text/plain'}, "Not Found"] if @hash['jobs'].byName[jobName].nil?


			job = @hash['jobs'].byName[jobName]
                        h = Hash['name',job.name,'next',job.next,'errorList',job.errorList]
            [ 200, {'Content-Type' => 'application/json'}, h.to_json ]


                when request.request_method == "POST" && section == "jobs" && parts.length == 4 && parts[3] == 'run' then
			jobName = parts[2]
                        [404, {'Content-Type' => 'text/plain'}, "Not Found"] if @hash['jobs'].byName[jobName].nil?

                @hash['jobs'].byName[ jobName ].runNow
            [ 200, {'Content-Type' => 'text/plain'}, "Ok" ]


		when request.request_method == "POST" && parts.length == 3 && parts[2] == 'run' then
		@hash['jobs'].byName[ parts[1] ].runNow
            [ 200, {'Content-Type' => 'text/plain'}, "Ok" ]
			
		else
            [ 200, {'Content-Type' => 'text/plain'}, "Ok" ]
	end

            
        end
    end
end

