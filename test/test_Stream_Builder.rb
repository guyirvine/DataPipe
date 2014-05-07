require 'test/unit'
require "./lib/StreamBuilder"


class Streamv1Test < Test::Unit::TestCase
    
    def test_EmptyStream
	s = StreamBuilder.new

        assert_equal '{"v":1,"d":{},"f":[],"l":[]}', s.serialize
    end


    def test_WithDefault
	s = StreamBuilder.new
		.set( "id", "AA" )
	assert_equal '{"v":1,"d":{"id":"AA"},"f":[],"l":[]}', s.serialize
    end

    def test_WithDefaults
        s = StreamBuilder.new
                .set( "id", "AA" )
                .set( "ts", "1 Jun 2014" )
        assert_equal '{"v":1,"d":{"id":"AA","ts":"1 Jun 2014"},"f":[],"l":[]}', s.serialize
    end

    def test_WithColumns
        s = StreamBuilder.new
                .f( ["id", "ts"] )
        assert_equal '{"v":1,"d":{},"f":["id","ts"],"l":[]}', s.serialize
    end

    def test_WithList_CorrectNumberOfFields
        s = StreamBuilder.new
                .f( ["id", "ts"] )
		.add( "1", "AA" )
        assert_equal '{"v":1,"d":{},"f":["id","ts"],"l":["1","AA"]}', s.serialize
    end

    def test_WithList_TwoRows_CorrectNumberOfFields
        s = StreamBuilder.new
                .f( ["id", "ts"] )
                .add( "1", "AA" )
                .add( "2", "BB" )
        assert_equal '{"v":1,"d":{},"f":["id","ts"],"l":["1","AA","2","BB"]}', s.serialize
    end

    def test_WithList_TwoRows_CorrectNumberOfFields
        s = StreamBuilder.new
                .f( ["id", "ts"] )
                .add( "1", "AA" )
                .add( "2", "BB" )
        assert_equal '{"v":1,"d":{},"f":["id","ts"],"l":["1","AA","2","BB"]}', s.serialize
    end

    def test_WithList_Default_TwoRows_CorrectNumberOfFields
        s = StreamBuilder.new
                .set( "id", "AA" )
                .f( ["value"] )
                .add( "1" )
                .add( "2" )
        assert_equal '{"v":1,"d":{"id":"AA"},"f":["value"],"l":["1","2"]}', s.serialize
    end



end

