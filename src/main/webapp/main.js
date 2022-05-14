function copy_to_clipboard(prefix,eleid)
{
    var copyText = document.getElementById(eleid);

    /* Copy the text inside the text field */
    navigator.clipboard.writeText(prefix+copyText.value);
}
function in_use_alert()
{
    alert("Link is already in use!! Please choose another link")
}