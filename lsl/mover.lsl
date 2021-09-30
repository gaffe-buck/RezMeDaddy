integer listener = 0;

default
{    
    on_rez(integer start_param)
    {
        listener = llListen(6969, "", "", "");
        llOwnerSay("Mover asking where");
        llRegionSay(6969, "WHR");
    }

    listen( integer channel, string name, key id, string message )
    {
        llOwnerSay("Mover received: " + message);
        string command = llGetSubString(message, 0, 2);
        if (command == "MOV")
        {
            llOwnerSay("Received command: MOV");
            string value = llGetSubString(message, 3, llStringLength(message)-1);
            vector where = (vector)(value);

            llSetPos(where);
            llListenRemove(listener);    
            llOwnerSay("Moved and killed listener.");
        }
    }
}