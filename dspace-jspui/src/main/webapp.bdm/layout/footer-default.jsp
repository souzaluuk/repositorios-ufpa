<%--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

--%>
<%--
  - Footer for home page
  --%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.net.URLEncoder" %>
<%@ page import="org.dspace.app.webui.util.UIUtil" %>

<%
    String sidebar = (String) request.getAttribute("dspace.layout.sidebar");
%>

            <%-- Right-hand side bar if appropriate --%>
<%
    if (sidebar != null)
    {
%>
	</div>
	<div class="col-md-3 col-md-pull-9">
                    <%= sidebar %>
    </div>
    </div>       
<%
    }
%>
</div>
</main>
            <%-- Page footer --%>
              <footer class="navbar-inverse nav-creditos " style="margin-top:15%"> <%--alteraçao de style 25% para 14%--%>
		<div id=" footer-institution-data2" style=" background-color:#CCC" class="row">
     			
			
			<div class="col-xs-6" style="margin-top:0px; text-align: left">                         
				<img src="/jspui/image/lado_a.png">
			</div>
				
			<div class="col-xs-6" style="margin-top:0px; text-align: right">                         
				<img src="/jspui/image/lado_b.png">
			</div>


		</div>


		</div>
			
    </footer>
    </body>
</html>
