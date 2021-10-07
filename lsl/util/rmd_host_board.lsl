// CHANGE THE DESCRIPTION OF THE OBJECT THIS SCRIPT IS IN TO THE KEY OF THE AVATAR

string NAME = "[Replace with the name or nickname of the avatar]";
key AVATAR = NULL_KEY;
integer SIDE = 0;

string status = "";
string profile_key_prefix = "<meta name=\"imageid\" content=\"";
string profile_img_prefix = "<img alt=\"profile image\" src=\"http://secondlife.com/app/image/";
integer profile_key_prefix_length; // calculated from profile_key_prefix in state_entry()
integer profile_img_prefix_length; // calculated from profile_key_prefix in state_entry()
 
GetProfilePic(key id) //Run the HTTP Request then set the texture
{
    string URL_RESIDENT = "http://world.secondlife.com/resident/";
    llHTTPRequest( URL_RESIDENT + (string)id,[HTTP_METHOD,"GET"],"");
}

default
{
    state_entry()
    {
        AVATAR = (key)llGetObjectDesc();
        profile_key_prefix_length = llStringLength(profile_key_prefix);
        profile_img_prefix_length = llStringLength(profile_img_prefix);
        GetProfilePic(AVATAR);
        llSetTimerEvent(10);
    }

    touch_start(integer total_number)
    {
        key id = llDetectedKey(0);
        llLoadURL(id,"","secondlife:///app/agent/"+(string)(AVATAR)+"/about");
    }

    http_response(key req,integer stat, list met, string body)
    {
        // first try
        integer s1 = llSubStringIndex(body, profile_key_prefix);
        integer s1l = profile_key_prefix_length;
        
        if(s1 == -1)
        {
            // second try
            s1 = llSubStringIndex(body, profile_img_prefix);
            s1l = profile_img_prefix_length;
        }
    
        s1 += s1l;
        key UUID=llGetSubString(body, s1, s1 + 35);
        llSetTexture(UUID, SIDE);
    }

    timer()
    {
        llRequestAgentData( AVATAR, DATA_ONLINE);
    }

    dataserver(key queryid, string data)
    {
        if ( data == "1" ) 
        {
            status = " is online";
 
            llSetText(NAME + status, <0,1,0>, 1.0);
        }
        else if (data == "0")
        {
            status = " is offline";
 
            llSetText(NAME + status, <1,0,0>, 1.0);
        }
    }
}