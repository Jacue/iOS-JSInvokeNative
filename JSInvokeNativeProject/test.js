
function hello(){
    alert("hello");
}

function getToken() {
    window.webkit.messageHandlers.getToken1.postMessage("showToken('deviceToken')");
}

function showToken (token) {
    alert(token);
}
