require "PgsqlToPgsql"


sql = "SELECT DISTINCT ptpt_code FROM milksolid.milksolids_tbl"
tableName = "temp_tbl"
columns = ["ptpt_code"]

PgsqlToPgsql( "Dw", "Db", sql, tableName, columns )


