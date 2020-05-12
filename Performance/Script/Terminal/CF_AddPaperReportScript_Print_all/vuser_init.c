vuser_init()
{
			 lr_db_connect("StepName=Connect", 
					"ConnectionString=Data Source=10.184.129.248\\GCPACSWS;Password=sa20021224$;User ID=sa;Initial Catalog=WGGC;", 
					"ConnectionName=ConnectGCPACS", 
					"ConnectionType=SQL", 
					LAST );

	return 0;
}
