require "DbToDir"

sql = "SELECT * FROM milksolid.milksolids_tbl"

DbToDir( "FarmwiseDb", sql, "ptpt_code", "./data", "milks" )


