<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.eyevinn.awmanager.AWCalendar" %>
<%@ page import="com.google.appengine.repackaged.org.joda.time.DateTime" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" type="text/css" href="stylesheets/main.css" />
    <link rel="stylesheet" type="text/css" href="http://www.eyevinn.se/Frontend/Styles/MyFontsWebfontsKit.css" />
    <link rel="stylesheet" type="text/css" href="http://www.eyevinn.se/Frontend/Styles/style.less" />
    <title>Nedräkning till nästa Eyevinn After Work</title>
    <script language="javascript" type="text/javascript">

    function timer(time, updatefn, completefn) {
        var start = new Date().getTime();
        var interval = setInterval(function() {
            var now = time - (new Date().getTime() - start);
            if (now <= 0) {
                clearInterval(interval);
                completefn();
            } else updatefn(Math.floor(now/1000));
        }, 1000);
    }

    function secToText(sec) {
        var days = Math.floor(sec / (24 * 3600));
        sec -= (days * 24*3600);
        var hours = Math.floor(sec / 3600);
        sec -= (hours * 3600);
        var minutes = Math.floor(sec / 60);
        sec -= (minutes * 60);
        sec = Math.floor(sec);

        var ds = " dagar, ";
        var hs = " timmar, ";
        var ms = " minuter, ";
        var ss = " sekunder";
        if (days < 2) { ds = " dag, "; }
        if (hours < 2) { hs = " timme, "; }
        if (minutes < 2) { ms = " minut, "; }
        if (sec < 2) { ss = " sekund"; }
        var s = days + ds + hours + hs + minutes + ms + sec + ss;
        return s;
    }
<%
    AWCalendar cal = new AWCalendar();
    DateTime nextAW = cal.nextAW();

%>
    timer(
        <%= nextAW.getMillis() - DateTime.now().getMillis() %>, // time left in milliseconds
        function(timeleft) {
            document.getElementById('timer').innerHTML = secToText(timeleft);
        },
        function() {
        }
    );
    </script>
</head>

<body class="frontpage">
    <div class="container-fluid main-container">
        <div>
            <div class="jumbotron jumbotron-light" style="background-image:url(&#39;http://www.eyevinn.se/media/a3c25452-5b53-4aed-9a21-8a193512a0ee/wt2GcA/Eyevinn/jacob1.jpg&#39;);">
                <div class="overlay">
                    <div class="container ">
                        <div class="jumbotron-content">
                            <p>Nästa Eyevinn After Work om</p>
                            <h1 id="timer">Kalkylerar...</h1>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>