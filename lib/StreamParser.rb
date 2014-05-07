module Telemetry
    
    require 'json'
    require 'date'

    class StreamParserError<StandardError
    end

    class VersionNotSpecifiedError<StreamParserError
    end
    class VersionNotSupportedError<StreamParserError
    end
    class MissingFormatError<StreamParserError
    end
    class InvalidFormatError<StreamParserError
    end
    class MissingListError<StreamParserError
    end
    class MeasurementFieldNotSuppliedError<StreamParserError
    end

    class StreamParser

        attr_reader :version, :list, :all_fields

        def method_missing( meth, *args, &block )
            raise VersionNotSupportedError.new if meth[0,5] == "parse"
            
            raise NoMethodError.new( "method: #{meth}" )
        end

        def parse1
            raise MissingFormatError.new if @r['f'].nil?
            raise InvalidFormatError.new if @r['f'].length == 0
            raise MissingListError.new if @r['l'].nil?

            @defaults = @r['d'] || {}

            @list = Array.new
            format = @r['f']

            @all_fields = @defaults.keys + @r['f']

            #Break list up into chunks, each chunk being the size of the format record
            @r['l'].each_slice( format.length ).with_index do |el,idx|

                obj = @defaults.clone
                format.each_with_index do |name,idx|
                    obj[name] = el[idx]
                end
                @list << obj
            end

        end

        def initialize( payload )
            @r = JSON.parse( payload )
            
            raise VersionNotSpecifiedError.new if @r['v'].nil?
            @version = @r['v']
            
            self.send "parse#{version}"
            
            return self
        end

    end

end

