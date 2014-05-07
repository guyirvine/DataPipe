require "DbToDir"
require "DbToJson"

sql = "SELECT * FROM milksolid.milksolids_tbl"

DbToDir( "FarmwiseDb", sql, "ptpt_code", "./data1", "milks-d" )
DbToJson( "FarmwiseDb", sql, "ptpt_code", "./data", "milks-j" )


