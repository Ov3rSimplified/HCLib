
--[[                       
    bbbbbbbb            
    HHHHHHHHH     HHHHHHHHH             CCCCCCCCCCCCC     LLLLLLLLLLL                    iiii       b::::::b            
    H:::::::H     H:::::::H          CCC::::::::::::C     L:::::::::L                   i::::i      b::::::b            
    H:::::::H     H:::::::H        CC:::::::::::::::C     L:::::::::L                    iiii       b::::::b            
    HH::::::H     H::::::HH       C:::::CCCCCCCC::::C     LL:::::::LL                                b:::::b            
        H:::::H     H:::::H        C:::::C       CCCCCC       L:::::L                    iiiiiii       b:::::bbbbbbbbb    
        H:::::H     H:::::H       C:::::C                     L:::::L                    i:::::i       b::::::::::::::bb  
        H::::::HHHHH::::::H       C:::::C                     L:::::L                     i::::i       b::::::::::::::::b 
        H:::::::::::::::::H       C:::::C                     L:::::L                     i::::i       b:::::bbbbb:::::::b
        H:::::::::::::::::H       C:::::C                     L:::::L                     i::::i       b:::::b    b::::::b
        H::::::HHHHH::::::H       C:::::C                     L:::::L                     i::::i       b:::::b     b:::::b
        H:::::H     H:::::H       C:::::C                     L:::::L                     i::::i       b:::::b     b:::::b
        H:::::H     H:::::H        C:::::C       CCCCCC       L:::::L         LLLLLL      i::::i       b:::::b     b:::::b
    HH::::::H     H::::::HH       C:::::CCCCCCCC::::C     LL:::::::LLLLLLLLL:::::L     i::::::i      b:::::bbbbbb::::::b
    H:::::::H     H:::::::H        CC:::::::::::::::C     L::::::::::::::::::::::L     i::::::i      b::::::::::::::::b 
    H:::::::H     H:::::::H          CCC::::::::::::C     L::::::::::::::::::::::L     i::::::i      b:::::::::::::::b  
    HHHHHHHHH     HHHHHHHHH             CCCCCCCCCCCCC     LLLLLLLLLLLLLLLLLLLLLLLL     iiiiiiii      bbbbbbbbbbbbbbbb   

< ---------- (INFORMATIONS) ---------- >
Author: TwinKlee / Ov3rSimplified
THIS IS THE LIBRARY FOR ALL OF HEXAGON CRYPTICS SCRIPTS!!




< ---------- (DONT EDIT ANYTHING OF THE CODE!!!) ---------- >
]]--  

--[[
 _______  _______           _______      _______  _______  _______  _______  _______           _______  _______  _       
(  ___  )(  ___  )|\     /|(  ____ \    (  ____ \(  ____ )(  ___  )(       )(  ____ \|\     /|(  ___  )(  ____ )| \    /\
| (   ) || (   ) || )   ( || (    \/    | (    \/| (    )|| (   ) || () () || (    \/| )   ( || (   ) || (    )||  \  / /
| |   | || (___) || | _ | || |          | (__    | (____)|| (___) || || || || (__    | | _ | || |   | || (____)||  (_/ / 
| |   | ||  ___  || |( )| || |          |  __)   |     __)|  ___  || |(_)| ||  __)   | |( )| || |   | ||     __)|   _ (  
| |   | || (   ) || || || || |          | (      | (\ (   | (   ) || |   | || (      | || || || |   | || (\ (   |  ( \ \ 
| (___) || )   ( || () () || (____/\    | )      | ) \ \__| )   ( || )   ( || (____/\| () () || (___) || ) \ \__|  /  \ \
(_______)|/     \|(_______)(_______/    |/       |/   \__/|/     \||/     \|(_______/(_______)(_______)|/   \__/|_/    \/


// Informations!
// Author: TwinKlee
// Startday: 27.06.2022 / 14:23
// FRAMEWORK FOR THE OAWC SCPRP !!
// YOUR NOT ALLOWED TO EDIT OR LEAK OR REUPLOAD THIS WITHOUT MY RELEASE !! 
]]

HCLIB.SQL = {};

print( "dd")

require( "mysqloo" );           

concommand.Add("SQL.DeleteTable", function(ply,_,args)

	sql.Query("DROP TABLE IF EXISTS `".. args[1] .."`", nil, nil)

end)

--[[ < ---------- ( Code ) ---------- > ]]--


function HCLIB.SQL.GetConnection()

	if not cookie.GetString( "HCLIB.SQL" ) then

		cookie.Set( "HCLIB.SQL", util.TableToJSON( { use = false, IP = "0.0.0.0", UserName = "", Password = "", Databasename = "", Port = "3306"  } ) );

		return { use = false, IP = "0.0.0.0", UserName = "", Password = "", Databasename = "", Port = "3306"  };

	end;

	local sqlt = util.JSONToTable( cookie.GetString( "HCLIB.SQL" ) )

	return sqlt;

end;


local ccfg = {
	
	mysql = HCLIB.SQL.GetConnection().use or false,

	host = HCLIB.SQL.GetConnection().IP or "",

	username = HCLIB.SQL.GetConnection().UserName or "",

	password = HCLIB.SQL.GetConnection().Password or "",

	schema = HCLIB.SQL.GetConnection().Databasename or "",

	port = HCLIB.SQL.GetConnection().Port or 3306

};



function HCLIB.SQL.Constructor( self, config )

	local sql = {};

	config = config or {};

	sql.config = ccfg;

	mysqloo.onConnected = function() end;

	sql.cache = {};

	setmetatable(sql, HCLIB.SQL);

	sql:RequireModule();

	return sql;

end;

local function querymysql( self, query, callback, errorCallback )

	if not query or not self.db then return end;

	local q = self.db:query( query );

	function q:onSuccess( data )

		if callback then
 
			callback( data );
		print( data[3]["Language"] )

		end;

	end;

	function q:onError(_, err)
        
		if not self.db or self.db:status() == mysqlOO.DATABASE_NOT_CONNECTED then

			table.insert(self.cache, {

				query = query,

				callback = callback,

				errorCallback = errorCallback

			});

			mysqloo:Connect(ccfg.host, ccfg.username, ccfg.password, ccfg.schema, ccfg.port);

			return;

		end;

		if errorCallback then

			errorCallback(err);

		end;

	end;

	q:start();

end;

local function querySQLite(self, query, callback, errorCallback)

	if not query then return end;

	sql.m_strError = "";

	local lastError = sql.LastError();

	local result = sql.Query(query);

	if sql.LastError() and sql.LastError() != lastError then

        local err = sql.LastError();

        if errorCallback then

            errorCallback(err, query);

        end;

        return;

	end;

	if callback then

		callback( result );

	end;

end;

function HCLIB.SQL:RequireModule()

	if not ccfg.mysql then return end;

	if not pcall( require, "mysqloo" ) then

		error("Couldn't find mysqlOO. Please install https://github.com/FredyH/mysqlOO. Reverting to SQLite");


		ccfg.mysql = false;

	end;

end;

function HCLIB.SQL:Connect()

	if ccfg.mysql then

		self.db = mysqloo.connect( ccfg.host, ccfg.username, ccfg.password, ccfg.schema, ccfg.port );

		self.db.onConnectionFailed = function(_, msg)

			timer.Simple(5, function()

				if not self then 
					
					return; 
				
				end;

				self:Connect( ccfg.host, ccfg.username, ccfg.password, ccfg.schema, ccfg.port );

			end );

			error("Connection failed! " .. tostring( msg ) ..	"\nTrying again in 5 seconds.");

		end;

		mysqloo.onConnected = function()

			for k, v in pairs( self.cache or {} ) do

				self:Query( v.query, v.callback, v.errorCallback );

			end;

			self.cache = {};

			mysqloo.onConnected();

		end;

		self.db:connect();

	end;

end;
 
function HCLIB.SQL:Disconnect()

	if IsValid( self.db ) then

		self.db:disconnect();

	end;

end;

function HCLIB.SQL:Query( query, callback, errorCallback )

	local func = ccfg.mysql and querymysql or querySQLite;

	func( self, query, callback, errorCallback );

end;

function HCLIB.SQL:QueryRow( query, row )

	row = row or 1;

	local r = HCLIB.SQL:Query( query, function( r )

		if ( r ) then 
			
			return r[ row ];
		
		end;
 
		return r;
		
	end, function( err )
		
		print( "Not Work!" )

	end );

	return r;

end;

function HCLIB.SQL:QueryValue( query )
	
	local r = HCLIB.SQL:QueryRow( query )

	if ( r ) then

		for k, v in pairs( r ) do 
			
			return v; 
		
		end;

	end;

	return r;

end;


function HCLIB.SQL:UsingMySQL()

	return HCLIB:GetConfigTable().Sql.UseMySQL;

end

function HCLIB.SQL:Escape(str)
	if self:UsingMySQL() then
		return string.Replace(self.db:escape(tostring(str)), "'", "")
	else
		return string.Replace(sql.SQLStr(str), "'", "")
	end
end

HCLIB.SQL.__index = HCLIB.SQL

setmetatable(HCLIB.SQL, {
	__call = HCLIB.SQL.Constructor
})
 
if HCLIB.SQL then 
	HCLIB.SQL:Disconnect()
end

HCLIB.SQL:Connect()


 





