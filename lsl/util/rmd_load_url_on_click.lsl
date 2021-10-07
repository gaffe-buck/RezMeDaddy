string INFO = "[Replace me with short description of the URL]";
string URL = "[Replace me with the URL]";
default
{
    touch_start(integer num_detected)
    {
        key id = llDetectedKey(0);
        integer avatar_in_this_sim = (llGetAgentSize(id) != ZERO_VECTOR); // TRUE or FALSE
 
        if (avatar_in_this_sim)
        {  
            llLoadURL(id, INFO, URL);
        }
    }
}
