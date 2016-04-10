// [NotificationBox] Closes/Hides box
function closeNotificationBox(url, expireDate) {
    try {
        document.getElementById('NotificationBoxHolder').style.display = 'none';
        
        if (url != "") {
            document.location = url;
        }
        
    } catch(e) {
        //Nothing
    }
}
