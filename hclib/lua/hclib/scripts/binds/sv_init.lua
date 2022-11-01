// Bind Manger by TwinKlee and Hexagon Cryptics Studios

util.AddNetworkString( "HCLIB.BM.GetDataonSpawn" );



hook.Add( "PlayerSpawn", "HCLIB.BM.GDOS", function( ply )

    if ( ply.BMSPINIT == true ) then 

        net.Start( "HCLIB.BM.GetDataonSpawn" );

        net.Send( ply );

    else
        
        return;

    end;
    
    ply.BMSPINIT = true;


end ); 