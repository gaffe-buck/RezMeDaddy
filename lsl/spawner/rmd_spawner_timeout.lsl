integer DIE_AFTER_SECONDS = 7200;

default
{
    timer()
    {
        llMessageLinked(LINK_THIS, 0, "DIE", llGetKey());
        llSetTimerEvent(0.0);
    }

    link_message(integer sender_num, integer num, string str, key id)
    {
        if (id != llGetKey()) {
            if (str == "BEG") {
                llSetTimerEvent(DIE_AFTER_SECONDS);
            }
            else if (str == "DIE") {
                llSetTimerEvent(0.0);
            }
        }
    }
}