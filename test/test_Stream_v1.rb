require 'test/unit'
require "./lib/StreamParser"


class Streamv1Test < Test::Unit::TestCase
    
    def test_MissingFormat
        string = '{ "v": "1" }'
        exceptionRaised = false
        begin
            m = Telemetry::StreamParser.new( string )
            rescue Telemetry::MissingFormatError=> e
            exceptionRaised = true
        end

        assert_equal true, exceptionRaised
    end

    def test_MissingList
        string = '{ "v": "1", "f": ["id"] }'
        exceptionRaised = false
        begin
            m = Telemetry::StreamParser.new( string )
            rescue Telemetry::MissingListError=> e
            exceptionRaised = true
        end

        assert_equal true, exceptionRaised
    end

    def test_ListNoDefaults
        string = '{ "v": "1", "f": ["id", "ts", "v"], "l": [1,"1 Jun 2012","A",2,"2 Jun 2012","B",3,"3 Jun 2012","C"] }'
        
        m = Telemetry::StreamParser.new( string )
        
        assert_equal 3, m.list.length
        assert_equal '{"id"=>1, "ts"=>"1 Jun 2012", "v"=>"A"}', m.list[0].to_s
    end
    
    def test_ListDefaultIdentifier
        string = '{ "v": "1", "d": {"id": 1}, "f": ["v","ts"], "l": ["A","1 Jun 2012","B","2 Jun 2012","C","3 Jun 2012"] }'

        m = Telemetry::StreamParser.new( string )

        assert_equal 3, m.list.length
        assert_equal '{"id"=>1, "v"=>"A", "ts"=>"1 Jun 2012"}', m.list[0].to_s
    end

    def test_ListDefaultTimestamp
        string = '{ "v": "1", "d": {"ts": "1 Jun 2012"}, "f": ["id", "v"], "l": ["A","1","B","2","C","3"] }'

        m = Telemetry::StreamParser.new( string )

        assert_equal 3, m.list.length
        assert_equal '{"ts"=>"1 Jun 2012", "id"=>"A", "v"=>"1"}', m.list[0].to_s
    end

    def test_AllFields

	string = '{ "v": "1", "d": {"ts": "1 Jun 2012"}, "f": ["id", "v"], "l": ["A","1","B","2","C","3"] }'

        m = Telemetry::StreamParser.new( string )

	assert_equal ["ts","id","v"], m.all_fields
    end

end

