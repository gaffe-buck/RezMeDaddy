string INFO = "Check out this helpful guide!";
string URL = "https://www.drauslittlewebsite.com/jasx/fright-how-to-play";
default
{
    touch_start(integer num_detected)
    {
        key     id              = llDetectedKey(0);
        integer avatarInSameSim = (llGetAgentSize(id) != ZERO_VECTOR);// TRUE or FALSE
 
        if (avatarInSameSim)
        {  
            llLoadURL(id, INFO, URL);
        }
    }
}
