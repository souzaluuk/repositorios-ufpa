<%--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

--%>
<%--
  - Renders a page containing a statistical summary of the repository usage
  --%>

<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>


<%-- Teste Com Comunidade --%>

<%@ page import="java.io.IOException" %>

<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.jsp.JspException" %>
<%@ page import="javax.servlet.jsp.JspWriter" %>
<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport" %>
<%@ page import="javax.servlet.jsp.tagext.TagSupport" %>

<%@ page import="org.apache.commons.lang.ArrayUtils" %>
<%@ page import="org.dspace.content.Community" %>
<%@ page import="org.dspace.content.Collection" %>

<%@ page import="org.dspace.core.Context" %>
<%@ page import="org.dspace.app.webui.util.UIUtil" %>


<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport" %>

<%-- Teste Com Comunidade --%>

<%-- Teste tradução meses --%>
<%@ page import="org.dspace.content.DCDate" %>
<%@ page import="org.dspace.app.webui.util.UIUtil" %>
<%-- Teste tradução meses --%>


<%@ taglib uri="http://www.dspace.org/dspace-tags.tld" prefix="dspace" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%
    String report = (String) request.getAttribute("report");
    Date[] months = (Date[]) request.getAttribute("months");
    String date = (String) request.getAttribute("date");
    Boolean general = (Boolean) request.getAttribute("general");
    String navbar = (String) request.getAttribute("navbar");
    
    SimpleDateFormat sdfDisplay = new SimpleDateFormat("MM'/'yyyy");
    SimpleDateFormat sdfLink = new SimpleDateFormat("yyyy'-'M");
	
	SimpleDateFormat justYear = new SimpleDateFormat("yyyy");
	SimpleDateFormat justMonth = new SimpleDateFormat("M");
%>
<%-- Teste Com Comunidade --%>
<%
	Context context = UIUtil.obtainContext(request);
	LocaleSupport locale = new LocaleSupport();
	Community[] communities = Community.findAll(context);
	Collection[] collections = Collection.findAll(context);
%>

<%!
	int setCommunities(JspWriter out, Community[] c, HttpServletRequest request, LocaleSupport locale, PageContext pageContext) throws JspException{
		try{
			out.println("<div>");
			out.println("	<div class=\"panel panel-success \">");
			out.println("		<div class=\"panel-heading facet-panel clickable-panel\">"+locale.getLocalizedMessage(pageContext,"jsp.statistics.report.communities")+"<span class=\"glyphicon glyphicon-plus pull-right\"></span></div>");
			out.println("			<ul class=\"list-group hideFacets\" style=\"display: none; overflow: auto; max-height: 230px;\">");
			for ( int i=0; i< c.length; i++ ){
				out.println("				<li class=\"list-group-item\">");
				out.println("					<a href=\""+request.getContextPath()+"/handle/"+c[i].getHandle()+"/statistics\">"+c[i].getName()+"</a>");
				out.println("				</li>");
			}
			out.println("			</ul>");			
			out.println("	</div>");
			out.println("</div>");
		}
		catch (IOException ie)
        {
            throw new JspException(ie);
        }
		
		return 1;
	}
%>

<%!
	int setCollections(JspWriter out, Collection[] c, HttpServletRequest request, LocaleSupport locale, PageContext pageContext) throws JspException{
		try{
			out.println("<div>");
			out.println("	<div class=\"panel panel-success \">");
			out.println("		<div class=\"panel-heading facet-panel clickable-panel\">"+locale.getLocalizedMessage(pageContext,"jsp.statistics.report.collections")+"<span class=\"glyphicon glyphicon-plus pull-right\"></span></div>");
			out.println("			<ul class=\"list-group hideFacets\" style=\"display: none; overflow: auto; max-height: 230px;\">");
			for ( int i=0; i< c.length; i++ ){
				out.println("				<li class=\"list-group-item\">");
				out.println("					<a href=\""+request.getContextPath()+"/handle/"+c[i].getHandle()+"/statistics\">"+c[i].getName()+"</a>");
				out.println("				</li>");
			}
			out.println("			</ul>");			
			out.println("	</div>");
			out.println("</div>");
		}
		catch (IOException ie)
        {
            throw new JspException(ie);
        }
		
		return 1;
	}
%>

<%!
	int setDates(JspWriter out, Date[] months, HttpServletRequest request, LocaleSupport locale, PageContext pageContext) throws JspException{
		
		SimpleDateFormat justYear = new SimpleDateFormat("yyyy");
		SimpleDateFormat justMonth = new SimpleDateFormat("M");
		try{
			out.println("<div>");
			out.println("	<div class=\"panel panel-success \">");
			out.println("		<div onclick=\"getSelected()\" class=\"panel-heading facet-panel clickable-panel\">"+locale.getLocalizedMessage(pageContext,"jsp.statistics.report.info2")+"<span class=\"glyphicon glyphicon-plus pull-right\"></span></div>");
			out.println("			<ul class=\"list-group hideFacets\" style=\"display: none;\">");
			
			/*for ( int i=months.length-1; i>months.length-7; i-- ){
				out.println("				<li class=\"list-group-item\">");
				out.println("					<a href=\""+request.getContextPath()+"/statistics?date="+sdfLink.format(months[i])+"\">"+sdfDisplay.format(months[i])+"</a>");
				out.println("				</li>");
			}*/
			
			out.println("				<li class=\"list-group-item\">");
			out.println("					<form id=\"date\" action=\"statistics\" >");
			out.println("						<select class=\"form-control\" id=\"ano\" onchange=\"selectMonths()\">");
			
			String anoAtual = "";
			String mesAtual = "";
			for (int i=0; i<months.length; i++ ){
				if (!anoAtual.equals(justYear.format(months[i]))){
					anoAtual = justYear.format(months[i]);
					out.println("							<option id=\"ano_"+anoAtual+"\"value=\""+anoAtual+"\">"+anoAtual+"</option>");				
				}
			}
			out.println("						</select>");
			out.println("						<select class=\"form-control\" id=\"mes\" >");
			out.println("						</select>");
			out.println("					<input class=\"css3button btn-default col-md-12\" type=\"button\" onclick=\"myFunction()\" value=\"Filtrar\" >");
			out.println("<br><br>");
			out.println("					</form>");
			out.println("				</li>");
			
			out.println("			</ul>");			
			out.println("	</div>");
			out.println("</div>");
		}
		catch (IOException ie)
        {
            throw new JspException(ie);
        }
		
		return 1;
	}
	
%>


<%-- Teste Com Comunidade --%>

<dspace:layout style="default" navbar="<%= navbar %>" titlekey="jsp.statistics.report.title">
	<script type="text/javascript" src="/jspui/statistics/files/tables.js"></script>
	
	<%
		if (months.length!=0){
	%>
	<script>
	function myFunction() {
		var mes = document.getElementById("mes").value;
		if (mes != ""){
			var x = document.getElementById("ano").value+"-"+mes;
			var y = document.createElement("input");
			y.setAttribute("name", "date");
			y.setAttribute("style", "display:none");
			y.setAttribute("value", x);
			document.getElementById("date").appendChild(y);
			
			document.getElementById("date").submit();
		}		
	}
	
	function selectMonths() {		
		var mes = document.getElementById("mes");
		var ano = document.getElementById("ano");
		
		if ( mes!=null && ano!=null){
			for ( i=mes.length; i > 0 ; i-- )
				mes.remove(0);
			
			arrayDates = new Array (<%
			String anoAtual = "";
			String mesAtual = "";
			int contYear=0;
			for (int i=0; i<months.length; i++ ){
				if (!anoAtual.equals(justYear.format(months[i]))){
					anoAtual = justYear.format(months[i]);
					mesAtual = justMonth.format(months[i]);
					if(contYear!=0){
						%>,<%
					}
					%>"<%=anoAtual%>"<%
					%>,<%=mesAtual%><%
					contYear++;
				}else{
					if (!mesAtual.equals(justMonth.format(months[i]))){
						mesAtual = justMonth.format(months[i]);
						%>,<%=mesAtual%><%
					}
				}
			}%>);
		
			arrayYears = new Array(ano.length);
			for ( i=0; i<ano.length; i++ )
				arrayYears[i] = ano[i].value;		
		
			for ( i=0; i<arrayDates.length; i++ ){
				if ( ano.value == arrayDates[i] ){
					for ( j=0; j<arrayYears.length; j++ )
						if (ano.value == arrayYears[j])
							break;
				
					for ( k=i+1; arrayDates[k] != arrayYears[j+1]; k++ ){
						var option = document.createElement("option");
						option.setAttribute("id","mes_"+arrayDates[k]);
						option.value = arrayDates[k];
						option.text = returnMonth(arrayDates[k]);
						mes.add(option);
					}
				}
			}
		}
	}
	
	function getSelected() {
		<%
			String strConsulta = request.getQueryString();
			if ( strConsulta != null){
				String strConsultaMes =  strConsulta.substring(10,strConsulta.length());
				String strConsultaAno = strConsulta.substring(5,9);
				%>
		document.getElementById("ano_<%=strConsultaAno%>").selected = "true";
		selectMonths();
		document.getElementById("mes_<%=strConsultaMes%>").selected = "true";
				<%
			}else{
				%>selectMonths();<%
			}			
		%>
	}
	
	//Retorna o mês de acordo do parâmetro 'num'
	function returnMonth(num){		
		switch(num){
			case 1:
				return "<%=DCDate.getMonthName(1, UIUtil.getSessionLocale(request))%>";
			case 2:
				return "<%=DCDate.getMonthName(2, UIUtil.getSessionLocale(request))%>";
			case 3:
				return "<%=DCDate.getMonthName(3, UIUtil.getSessionLocale(request))%>";
			case 4:
				return "<%=DCDate.getMonthName(4, UIUtil.getSessionLocale(request))%>";
			case 5:
				return "<%=DCDate.getMonthName(5, UIUtil.getSessionLocale(request))%>";
			case 6:
				return "<%=DCDate.getMonthName(6, UIUtil.getSessionLocale(request))%>";
			case 7:
				return "<%=DCDate.getMonthName(7, UIUtil.getSessionLocale(request))%>";
			case 8:
				return "<%=DCDate.getMonthName(8, UIUtil.getSessionLocale(request))%>";
			case 9:
				return "<%=DCDate.getMonthName(9, UIUtil.getSessionLocale(request))%>";
			case 10:
				return "<%=DCDate.getMonthName(10, UIUtil.getSessionLocale(request))%>";
			case 11:
				return "<%=DCDate.getMonthName(11, UIUtil.getSessionLocale(request))%>";
			case 12:
				return "<%=DCDate.getMonthName(12, UIUtil.getSessionLocale(request))%>";
			default:
				return "FAIL";
		}		
	}
	</script>
	<%
		}
	%>
	
	<div class="col-md-9 col-md-push-3">
		<div class="panel panel-warning" style="min-height: 400px" >
			<%= report %>
		</div>
	</div>

	<div class="col-md-3 col-md-pull-9">
		<div class="col-md-12">
		<%
    if (general.booleanValue())
    {
%>
    <a class="btn btn-success col-md-12"><fmt:message key="jsp.statistics.report.info1"/></a>
<%
    }
    else
    {
%>
    <a class="btn btn-info col-md-12" href="<%= request.getContextPath() %>/statistics"><fmt:message key="jsp.statistics.report.info1"/></a>
<%
    }
	%><br><br><br>
		<%
	
				if ( months.length != 0 ){
					setDates(out, months, request, locale, pageContext);
				}
				
				if ( communities.length != 0 ){
					setCommunities(out, communities, request, locale, pageContext);
				}
				if ( collections.length != 0 ){
					setCollections(out, collections, request, locale, pageContext);
				}					
			%>
		</div>
	</div>

	
</dspace:layout>
