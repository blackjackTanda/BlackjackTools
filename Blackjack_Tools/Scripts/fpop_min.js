/* XIVDB TT Version: 3.2 */
function fPopGetScript(a, d) {
    var b = document.createElement("script");
    b.src = a;
    var c = document.getElementsByTagName("head")[0], e = !1;
    void 0 == c && (c = document.getElementsByTagName("body")[0]);
    b.onload = b.onreadystatechange = function () {
        e || this.readyState && "loaded" != this.readyState && "complete" != this.readyState || (e = !0, d(), b.onload = b.onreadystatechange = null, c.removeChild(b))
    };
    c.appendChild(b)
}
function fPopLoadTips() {
    "undefined" != typeof Prototype && jQuery.noConflict();
    jQuery.fn.simpletooltip || function (a) {
        a.fn.simpletooltip = function () {
            return this.each(function () {
                void 0 != a(this).data("tooltip") && (a(this).hover(function (b) {
                    a("#simpleTooltip").remove();
                    var c = a(this).data("tooltip"), e = b.pageX + 5;
                    b = b.pageY + 5; a("body").append("<div id='simpleTooltip' style='position: absolute; z-index: 100; display: none;'>" + c + "</div>");
                    c = a("#simpleTooltip").width(); a("#simpleTooltip").width(c); a("#simpleTooltip").css("left", e).css("top", b).show()
                },
                function () {
                    a("#simpleTooltip").remove()
                }), a(this).mousemove(function (b)
                { var c = b.pageX + 12, e = b.pageY + 12, f = a("#simpleTooltip").outerWidth(!0), g = a("#simpleTooltip").outerHeight(!0); c + f > a(window).scrollLeft() + a(window).width() && (c = b.pageX - f); a(window).height() + a(window).scrollTop() < e + g && (e = b.pageY - g); a("#simpleTooltip").css("left", c).css("top", e).show() }))
            })
        }
    } (jQuery); var a = setInterval(function () { "complete" === document.readyState && (clearInterval(a), fPopLoadItem()) }, 10)
}
function fPopLoadItem() {
    "undefined" != typeof Prototype && jQuery.noConflict(); jQuery("a").each(function () {
        var a = jQuery(this).attr("href"); if (void 0 != a && (a = a.split("/"), "xivdb.com" == a[2] || "www.xivdb.com" == a[2] || "xivdatabase.com" == a[2] || "www.xivdatabase.com" == a[2] || "jp.xivdb.com" == a[2] || "en.xivdb.com" == a[2] || "de.xivdb.com" == a[2] || "fr.xivdb.com" == a[2])) {
            var d = jQuery(this), b = []; b.JP = 0; b.EN = 1; b.DE = 2; b.FR = 3; (b = b[getUrlVars("fpop_min.js").language]) || (b = 1); fPopDebug && console.log(b); fPopDebug && console.log(getUrlVars("fpop_min.js").language);
            fPopDebug && console.log(getUrlVars("fpop_min.js")); var c = a[4]; void 0 == a[4] || (!jQuery.isNumeric(a[4]) || "?item" != a[3] && "?skill" != a[3] && "?recipe" != a[3]) || (fPopDebug && console.log("XIVDB: Loading Item:"), fPopDebug && console.log(a), jQuery.ajax({ url: "http://www.xivtooltips.com/modules/fpop/fpop.php", data: { id: c, Language: b, type: a[3], Location: window.location.toString() }, dataType: "jsonp", success: function (a) { d.attr("href") == d.html() && d.html(a.name); d.data("tooltip", a.html); d.simpletooltip({ fixed: !0, position: "bottom" }) },
                error: function (a, b, c) { console.log(b); console.log(c) }
            }))
        }
    })
} function fPopInit() { fPopDebug && console.log("Loading XIVDB Tooltips..."); "undefined" == typeof jQuery ? fPopGetScript("http://www.xivtooltips.com/scripts/jquery/jquery.js", fPopLoadTips) : fPopLoadTips() }
if ("function" != typeof getUrlVars) var getUrlVars = function (a) { for (var d = document.getElementsByTagName("script"), b = 0; b < d.length; b++) if (-1 < d[b].src.indexOf("/" + a)) { a = d[b].src.split("?").pop().split("&"); d = {}; for (b = 0; b < a.length; b++) { var c = a[b].split("="); d[c[0]] = c[1] } return d } return {} }; var fPopDebug = !1;
window.onload = function () { var a = document.createElement("link"); a.setAttribute("rel", "stylesheet"); a.setAttribute("href", "http://xivtooltips.com/css/fpop_tt.css"); a.setAttribute("type", "text/css"); document.getElementsByTagName("head")[0].appendChild(a); fPopInit() };