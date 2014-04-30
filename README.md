#DataPipe

Ease the movement of data

##Current libs

###DbToDir
Provide a FluidDb uri, and SQL Query and an export directory, and this will export your data

###PathToRemote
Provide a path and an scp uri, and this will use scp to copy your files

###SqlServerToPgsql
Provide 2 FluidDb uri's, one to a source SQL Server, one to destination Postgres Server, a SQL Query, destination table name and destination column names, and this will copy the data across as efficiently as possible.

###PgsqlToPgsql.rb	
Provide 2 FluidDb uri's, one to a source Postgres Server, one to destination Postgres Server, a SQL Query, destination table name and destination column names, and this will copy the data across as efficiently as possible.


##Environment Variables
When are they used ?
What can change through deployment.

##CRON
By default these scripts are run,
on startup,
at midnight from then on.

This can be overridden by providing a cron syntax through the environment variable, "CRON_<script_name>" on the command line.

##Exceptions
When exceptions do occur, we want as much detail as we can intelligently generate in order to diagnose the problem.
We also want to be able to re-run easily if possible.

