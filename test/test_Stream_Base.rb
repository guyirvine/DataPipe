require 'test/unit'
require "./lib/StreamParser"

class StreamBase_StreamParser<Telemetry::StreamParser
    
    attr_accessor :r
    
    def parse1
    end
    
end


class StreamBaseTest < Test::Unit::TestCase
    
    def test_NoVersion
        string = '{}'

        exceptionRaised = false
        begin
            m = Telemetry::StreamParser.new( string )
            rescue Telemetry::VersionNotSpecifiedError=> e
            exceptionRaised = true
        end

        assert_equal true, exceptionRaised
    end

    def test_SpecifyVersion
        string = '{ "v": "1" }'
        m = StreamBase_StreamParser.new( string )
        
        assert_equal '1', m.version
    end
    
    def test_UnsupportedVersion
        string = '{ "v": "2" }'

        exceptionRaised = false
        begin
            m = Telemetry::StreamParser.new( string )
            rescue Telemetry::VersionNotSupportedError=> e
            exceptionRaised = true
        end

        assert_equal true, exceptionRaised
    end
    
end

