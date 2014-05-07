require 'json'


class StreamBuilder

	def initialize
		@h = Hash['v',1,'d',{},'f',[],'l',[]]
	end

	def set( name, value )
		@h['d'][name] = value
		return self
	end

	def f( fieldList )
		@h['f'] = fieldList

		return self
	end

	def add( *args )
		@h['l'].concat args

		return self
	end

	def serialize
		return @h.to_json
	end

end

