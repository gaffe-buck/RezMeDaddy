default
{
    touch_start(integer total_number)
    {
        key user = llDetectedKey(0);
        llGiveInventory(user, llGetInventoryName(INVENTORY_LANDMARK, 0) );
    }
}