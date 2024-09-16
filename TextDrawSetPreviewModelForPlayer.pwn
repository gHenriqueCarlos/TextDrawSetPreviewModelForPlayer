stock bool:TextDrawSetPreviewModelForPlayer(playerid, Text:textid, model)
{
    if(!IsPlayerConnected(playerid)) 
        return false;

    if(!IsValidTextDraw(textid))
    	return false;

    new 
        BitStream:bs = BS_New(), 
        Float:width, Float:height, 
        Float:line_width, Float:line_height, 
        Float:x, Float:y, 
        Float:rotationX, Float:rotationY, Float:rotationZ, Float:zoom,
        colour1, colour2
    ;

    TextDrawGetLetterSize(textid, width, height);
    TextDrawGetTextSize(textid, line_width, line_height);
    TextDrawGetPos(textid, x, y);
    TextDrawGetPreviewRot(textid, rotationX, rotationY, rotationZ, zoom);
    TextDrawGetPreviewVehicleColours(textid, colour1, colour2);

    BS_WriteValue(
        bs,
        PR_INT16, _:textid,
        PR_UINT8, TextDrawIsBox(textid) | (TextDrawGetAlignment(textid) << 1) | (TextDrawIsProportional(textid) << 4),
        PR_FLOAT, width,
        PR_FLOAT, height,
        PR_UINT32, TextDrawGetColour(textid),
        PR_FLOAT, line_width,
        PR_FLOAT, line_height,
        PR_UINT32, TextDrawGetBoxColour(textid),
        PR_UINT8, TextDrawGetShadow(textid),
        PR_UINT8, TextDrawGetOutline(textid),
        PR_UINT32, TextDrawGetBackgroundColour(textid),
        PR_UINT8, TextDrawGetFont(textid),
        PR_UINT8, TextDrawIsSelectable(textid),
        PR_FLOAT, x,
        PR_FLOAT, y,
        PR_INT16, model,
        PR_FLOAT, rotationX,
        PR_FLOAT, rotationY,
        PR_FLOAT, rotationZ,
        PR_FLOAT, zoom,
        PR_INT16, colour1,
        PR_INT16, colour2,
        PR_INT16, 1, 
        PR_STRING, "_"
    );

    PR_SendRPC(bs, playerid, 134);
    BS_Delete(bs);

    return true;
}