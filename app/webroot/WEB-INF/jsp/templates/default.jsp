<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://aspectran.com/tags" prefix="aspectran" %>
<!DOCTYPE html>
<html class="no-js" lang="en">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=initial-scale=1.0, user-scalable=no"/>
    <meta name="google" content="notranslate">
    <title>JPetStore Demo</title>
    <meta name="description" content="JPetStore is a full web application built on top of MyBatis 3, Aspectran 8."/>
    <link rel="stylesheet" type="text/css" href="https://assets.aspectran.com/foundation/css/aspectran.css"/>
    <link rel="stylesheet" type="text/css" href="<aspectran:url value="/css/jpetstore.css"/>"/>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,400;0,700;1,400&display=swap">
    <script src="https://assets.aspectran.com/js/modernizr-custom.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://unpkg.com/htmx.org@2.0.4"></script>
    <link rel="mask-icon" href="https://assets.aspectran.com/img/aspectran-logo.svg" color="#4B555A"/>
    <link rel="apple-touch-icon" sizes="57x57" href="https://assets.aspectran.com/img/apple-icon-57x57.png"/>
    <link rel="apple-touch-icon" sizes="60x60" href="https://assets.aspectran.com/img/apple-icon-60x60.png"/>
    <link rel="apple-touch-icon" sizes="72x72" href="https://assets.aspectran.com/img/apple-icon-72x72.png"/>
    <link rel="apple-touch-icon" sizes="76x76" href="https://assets.aspectran.com/img/apple-icon-76x76.png"/>
    <link rel="apple-touch-icon" sizes="114x114" href="https://assets.aspectran.com/img/apple-icon-114x114.png"/>
    <link rel="apple-touch-icon" sizes="120x120" href="https://assets.aspectran.com/img/apple-icon-120x120.png"/>
    <link rel="apple-touch-icon" sizes="144x144" href="https://assets.aspectran.com/img/apple-icon-144x144.png"/>
    <link rel="apple-touch-icon" sizes="152x152" href="https://assets.aspectran.com/img/apple-icon-152x152.png"/>
    <link rel="apple-touch-icon" sizes="180x180" href="https://assets.aspectran.com/img/apple-icon-180x180.png"/>
    <link rel="icon" type="image/png" sizes="192x192"  href="https://assets.aspectran.com/img/android-icon-192x192.png"/>
    <link rel="icon" type="image/png" sizes="16x16" href="https://assets.aspectran.com/img/favicon-16x16.png"/>
    <link rel="icon" type="image/png" sizes="32x32" href="https://assets.aspectran.com/img/favicon-32x32.png"/>
    <link rel="icon" type="image/png" sizes="96x96" href="https://assets.aspectran.com/img/favicon-96x96.png"/>
    <meta name="msapplication-TileImage" content="https://assets.aspectran.com/img/ms-icon-144x144.png"/>
    <meta name="msapplication-TileColor" content="#4B555A"/>
</head>
<body id="top-of-page" class="plate solid" itemscope itemtype="https://schema.org/WebPage">
<nav id="navigation" class="no-js">
    <div class="title-bar" data-responsive-toggle="gnb-menu" data-hide-for="large" style="display:none">
        <div class="title-bar-left">
            <a class="logo" href="/" title="Aspectran"><img src="https://assets.aspectran.com/img/aspectran-site-logo.png" alt="Aspectran"/></a>
        </div>
        <div class="title-bar-center">
            <a href="#top-of-page">Aspectran</a>
        </div>
        <div class="title-bar-right" data-toggle="gnb-menu">
            <a class="menu-icon" title="Menu"></a>
        </div>
    </div>
    <div class="top-bar" id="gnb-menu" style="display:none">
        <div class="grid-container ${page.style}">
            <div class="top-bar-logo">
                <div class="circle">
                    <a class="logo" href="<aspectran:url value="/"/>" title="Aspectran"><img src="https://assets.aspectran.com/img/aspectran-site-logo.png" alt="Aspectran"/></a>
                </div>
            </div>
            <div class="top-bar-left">
                <ul class="dropdown menu" data-dropdown-menu>
                    <li>
                        <a>Get Involved</a>
                        <ul class="submenu menu vertical" data-submenu>
                            <li><a href="https://github.com/aspectran/aspectran-jpetstore">GitHub</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="https://public.aspectran.com/" title="Sample applications built on Aspectran">More Sample Apps</a>
                        <ul class="submenu menu vertical" data-submenu>
                            <li><a href="https://demo.aspectran.com">Aspectran Demo</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
            <div class="top-bar-right">
                <ul class="dropdown menu" data-dropdown-menu>
                    <aspectran:profile expression="h2">
                        <li><a href="<aspectran:url value="/h2-console/"/>" target="_blank">H2 Console</a></li>
                    </aspectran:profile>
                    <li><a href="<aspectran:url value="/monitoring/#jpetstore"/>">Monitoring</a></li>
                </ul>
                <div class="quick-search-box">
                    <form name="google_quick_search">
                        <div class="input-group">
                            <input class="input-group-field" type="text" name="keyword" placeholder="Search">
                            <div class="input-group-button">
                                <button type="submit" class="button"><i class="fi-magnifying-glass"></i></button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div class="breadcrumbs-bar" style="display:none" data-hide-for="medium down">
            <div class="grid-container ${page.style}">
                <nav role="navigation" aria-label="You are here:">
                    <ul class="breadcrumbs" itemprop="breadcrumb">
                        <li><a href="<aspectran:url value="https://public.aspectran.com/"/>">Sample Apps</a></li>
                        <li><a href="<aspectran:url value="/"/>">JPetStore Demo</a></li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</nav>
<section itemscope itemtype="https://schema.org/Article">
    <div id="masthead">
        <div class="grid-container ${page.style}">
            <div class="grid-x">
                <div class="small-12 cell">
                    <header>
                        <p class="subheadline" itemprop="alternativeHeadline">
                            A full-stack sample web application built on top of Aspectran 8 and MyBatis 3</p>
                        <h1 itemprop="headline">JPetStore Demo</h1>
                        <p class="teaser" itemprop="description">
                            The goal of the JPetStore Demo App is to provide a fully functional web application that leverages Aspectran and MyBatis.
                        </p>
                    </header>
                    <div class="hexagons">
                        <div class="hexagon hex1"></div>
                        <div class="hexagon hex2"></div>
                        <div class="hexagon hex3"></div>
                        <div class="hexagon hex5"></div>
                        <div class="hexagon hex6"></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="grid-container grid-x breadcrumbs-bar ${page.style}">
            <div class="cell">
                <nav role="navigation" aria-label="You are here:">
                    <ul class="breadcrumbs" itemprop="breadcrumb">
                        <li><a href="<aspectran:url value="https://public.aspectran.com/"/>">Sample Apps</a></li>
                        <li><a href="<aspectran:url value="/"/>">JPetStore Demo</a></li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
    <c:if test="${page.style eq 'fluid'}">
    <div id="window" class="grid-container fluid cell contour">
        <c:if test="${not empty INCLUDE_PAGE}">
            <jsp:include page="/WEB-INF/jsp/${INCLUDE_PAGE}.jsp"/>
        </c:if>
    </div>
    </c:if>
    <c:if test="${page.style ne 'fluid'}">
    <div id="window" class="grid-container" style="padding:0;">
        <c:if test="${not empty INCLUDE_PAGE}">
            <jsp:include page="/WEB-INF/jsp/${INCLUDE_PAGE}.jsp"/>
        </c:if>
    </div>
    </c:if>
</section>
<div class="grid-container ${page.style}">
    <div id="up-to-top" class="grid-x">
        <div class="small-12 cell" style="text-align: right;">
            <a class="iconfont" href="#top-of-page">&#xf108;</a>
        </div>
    </div>
</div>
<footer id="footer-content">
    <div id="footer">
        <div class="grid-container">
            <div class="grid-x grid-padding-x">
                <div class="medium-2 large-1 cell hide-for-small-only t5">
                    <h5><a class="logo" href="https://aspectran.com/en/aspectran/" title="Aspectran"><img src="https://assets.aspectran.com/img/aspectran-logo-grey-x100.png" width="100" height="100" alt="Aspectran" title="Aspectran"/></a></h5>
                </div>
                <div class="medium-4 large-4 cell">
                    <a href="https://aspectran.com/en/aspectran/"><h5>About Aspectran</h5></a>
                    <p><a href="https://aspectran.com/en/aspectran/">Aspectran is a framework for developing Java applications that can be used to build simple shell applications and large enterprise web applications.</a></p>
                </div>
                <div class="small-6 medium-3 large-3 large-offset-1 cell">
                    <h5>Get Involved</h5>
                    <ul class="no-bullet">
                        <li class="icon-github"> <a href="https://github.com/aspectran" target="_blank" title="" class="external">GitHub</a></li>
                    </ul>
                </div>
                <div class="small-6 medium-3 large-3 cell">
                    <h5>Support</h5>
                    <ul class="no-bullet">
                        <li><a href="https://aspectran.com/en/support/faq/" title="Frequently Asked Questions about Aspectran">FAQ</a></li>
                        <li><a href="https://aspectran.com/en/support/contact/" title="Contact Us">Contact Us</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div id="subfooter">
        <div class="grid-container">
            <nav class="grid-x b30">
                <section id="subfooter-left" class="medium-6 cell credits">
                    <p>Copyright © 2018-2025 The Aspectran Project</p>
                </section>
                <section id="subfooter-right" class="medium-6 cell social-icons text-right">
                    <%= com.aspectran.core.AboutMe.POWERED_BY_LINK %>
                </section>
            </nav>
        </div>
    </div>
</footer>
<script src="https://assets.aspectran.com/foundation/js/foundation.min.js"></script>
<script>
    $(document).foundation();
    $(function() {
        let $win = $(window);
        let $nav = $("#navigation");
        let navHeight = $("#masthead").height() - $nav.height();
        let lastScrollTop = 0;
        let scrolled;
        let navFixed;
        $win.scroll(function() {
            scrolled = true;
        });
        setInterval(function() {
            if (scrolled) {
                let scrollTop = $win.scrollTop();
                if (Math.abs(lastScrollTop - scrollTop) <= 10) {
                    return;
                }
                if (scrollTop <= navHeight) {
                    if (navFixed) {
                        $nav.removeClass("fixed");
                        navFixed = false;
                    }
                } else if (scrollTop > lastScrollTop) {
                    if (navFixed) {
                        $nav.removeClass("fixed");
                        navFixed = false;
                    }
                } else {
                    if (!navFixed) {
                        if ($nav.hasClass("immediate")) {
                            $nav.removeClass("immediate")
                        } else {
                            $nav.addClass("fixed");
                            $nav.hide().fadeIn(500);
                            navFixed = true;
                        }
                    }
                }
                lastScrollTop = scrollTop;
                scrolled = false;
            }
        }, 200);
        /* google search */
        $("form[name=google_quick_search]").submit(function(event) {
            window.open('https://www.google.com/search?q=' + this.keyword.value + '+site:{{ site.url | cgi_escape }}');
            event.preventDefault();
        });
    });
</script>
<script>
    $(function() {
        $("#masthead h1, article h1, article h2, article h3, article h4, article h5, article h6").each(function(index, item) {
            let tagn = item.localName;
            let anchor = "top-of-page";
            if (tagn !== "h1") {
                anchor = "anchor-" + (index + 1);
                $(this).before("<a class='toc-anchor " + anchor + "' id='" + anchor + "' name='" + anchor + "'></a>");
            }
            $("#toc ul").append("<li class='toc-" + tagn + "'><a anchor='" + anchor + "' href='#" + anchor + "'>" + $(item).text() + "</a></li>");
        });
    });
</script>
<script>
    $(function() {
        $(".lazy-sticky").each(function() {
            const $win = $(window);
            const $this = $(this);
            const baseOffsetTop = $this.offset().top;
            const upToTopHeight = $("#up-to-top").height() + 30 + 60;
            let footerHeight = $("#footer-content").height() + upToTopHeight;
            let offsetTop = 0;
            let thisHeight = $this.height();
            let winHeight = $win.height();
            let scrollTimer = null;
            let immediate = false;
            $this.find("#toc ul a").click(function(e) {
                immediate = true;
                let anchor = $(this).attr("anchor");
                if (anchor !== "top-of-page") {
                    $("#navigation").addClass("immediate");
                }
            });
            $win.scroll(function() {
                let scrollTop = $win.scrollTop();
                if (scrollTop < baseOffsetTop) {
                    if (scrollTimer) {
                        clearInterval(scrollTimer);
                        scrollTimer = null;
                    }
                    scrollTimer = setInterval(function() {
                        if (offsetTop !== 0) {
                            $this.css({
                                top: 0
                            });
                        }
                        offsetTop = 0;
                        clearInterval(scrollTimer);
                        scrollTimer = null;
                        immediate = false;
                    }, immediate ? 250 : 500);
                } else {
                    let topBarHeight = $("#navigation.fixed .top-bar").height()||0;
                    if (immediate || (scrollTop > baseOffsetTop + topBarHeight + offsetTop + thisHeight - 20) ||
                        (scrollTop < baseOffsetTop + topBarHeight + offsetTop)) {
                        if ($this.offset().left >= 15 && $this.width() < 500) {
                            if (scrollTimer) {
                                clearInterval(scrollTimer);
                                scrollTimer = null;
                            }
                            scrollTimer = setInterval(function() {
                                topBarHeight = $("#navigation.fixed .top-bar").height()||0;
                                scrollTop = $win.scrollTop();
                                if (scrollTop < baseOffsetTop + topBarHeight) {
                                    scrollTop = 0;
                                } else {
                                    scrollTop = scrollTop - baseOffsetTop + topBarHeight + 30;
                                }
                                if (scrollTop > $(document).height() - footerHeight - thisHeight - baseOffsetTop + topBarHeight) {
                                    scrollTop = $(document).height() - footerHeight - thisHeight - baseOffsetTop + topBarHeight;
                                }
                                offsetTop = scrollTop;
                                $this.css({
                                    position: "relative"
                                });
                                $this.animate({
                                    top: scrollTop + "px"
                                }, 300);
                                clearInterval(scrollTimer);
                                scrollTimer = null;
                                winHeight = $win.height();
                                thisHeight = $this.height();
                                footerHeight = $("#footer-content").height() + upToTopHeight;
                                immediate = false;
                            }, immediate ? 250 : 500);
                        }
                    }
                }
            });
            $win.resize(function() {
                if ($this.offset().left < 15 || $this.width() >= 500) {
                    clearInterval(scrollTimer);
                    $this.css("top", 0);
                } else {
                    $win.scroll();
                }
            });
            setTimeout(function() {
                if ($win.scrollTop() > baseOffsetTop) {
                    offsetTop = $win.scrollTop();
                    $win.scroll();
                }
            }, 150);
        });
    });
</script>
<script>
    /* Creating custom :external selector */
    $.expr[':'].external = function(obj) {
        return obj.href
            && !obj.href.match(/aspectran.com\//)
            && !obj.href.match(/^javascript:/)
            && !obj.href.match(/^mailto:/)
            && (obj.hostname !== location.hostname);
    };
    $(function() {
        /* Add 'external' CSS class to all external links */
        $('a:external').addClass('external');
        /* turn target into target=_blank for elements w external class */
        $('.external').attr('target','_blank');
    })
</script>
<script>
    $(function() {
        let menuitem = $("#gnb-menu .top-bar-left .dropdown li a[href='" + location.pathname + "']").last();
        if (menuitem.length > 0) {
            let arr = [];
            arr.push({'name': menuitem.text(), 'href': null});
            menuitem.parentsUntil(".dropdown > li:eq(0)").each(function() {
                if ($(this).hasClass("menu")) {
                    let a2 = $(this).prev();
                    if (a2.is("a")) {
                        arr.push({'name': a2.text(), 'href': a2.attr("href") || ""});
                    }
                }
            });
            arr.reverse();
            for (let i in arr) {
                let item = arr[i];
                if (i < arr.length - 1) {
                    $(".breadcrumbs").append("<li><a href='" + item.href + "'>" + item.name + "</a></li>");
                } else {
                    $(".breadcrumbs").append("<li><span class='show-for-sr'>Current: </span> <span class='current'>" + item.name + "</span></li>");
                }
            }
        }
    });
</script>
</body>
</html>
