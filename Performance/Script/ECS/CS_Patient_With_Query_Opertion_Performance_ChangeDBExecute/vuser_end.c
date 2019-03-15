vuser_end()
{
	mysql_close(db_connection);
	return 0;
}
