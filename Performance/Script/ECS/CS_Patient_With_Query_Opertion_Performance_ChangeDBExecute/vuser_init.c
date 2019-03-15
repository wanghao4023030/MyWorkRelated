vuser_init()
{
		 
//	  // You should be able to find the MySQL DLL somewhere in your MySQL install directory.
//	  rc = lr_load_dll ("libmysql.dll");
//	  if (rc != 0) {
//	    lr_error_message("Could not load libmysql.dll");
//	    //lr_exit(LR_EXIT_ITERATION_AND_CONTINUE,LR_FAIL);
//	    return 0;
//
//	  }
//		 
//	  // Allocate and initialise a new MySQL object
//	  db_connection = mysql_init(NULL);
//	  if (db_connection == NULL) {
//	    lr_error_message("Insufficient memory init my SQL failed.");
//	    //lr_exit(LR_EXIT_ITERATION_AND_CONTINUE,LR_FAIL);
//	    return 0;
//	  }
//	 
//	  // Connect to the database
//	  rc = mysql_real_connect(db_connection, server, user, password, database, port, unix_socket, flags);
//	  if (rc == NULL) {
//	    //lr_error_message("%s", mysql_error(db_connection));
//	    lr_fail_trans_with_error("%s",mysql_error(db_connection) );
//	    mysql_close(db_connection);
//	    //lr_exit(LR_EXIT_ITERATION_AND_CONTINUE,LR_FAIL);
//	    return 0;
//	  }
//	
	return 0;
}
