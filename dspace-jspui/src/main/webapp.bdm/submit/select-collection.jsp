<%--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

--%>
<%--
  - UI page for selection of collection.
  -
  - Required attributes:
  -    collections - Array of collection objects to show in the drop-down.
  --%>

<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport" %>

<%@ page import="org.dspace.core.Context" %>
<%@ page import="org.dspace.app.webui.servlet.SubmissionController" %>
<%@ page import="org.dspace.submit.AbstractProcessingStep" %>
<%@ page import="org.dspace.app.webui.util.UIUtil" %>
<%@ page import="org.dspace.content.Collection" %>

<%-- 26/12/2017 --%>
<%@ page import="org.dspace.app.util.CollectionDropDown" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.Comparator" %>
<%@ page import="java.sql.SQLException" %>
<%-- 26/12/2017 --%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"
    prefix="fmt" %>
	
<%@ taglib uri="http://www.dspace.org/dspace-tags.tld" prefix="dspace" %>

<%
	request.setAttribute("LanguageSwitch", "hide");

    //get collections to choose from
    Collection[] collections =
        (Collection[]) request.getAttribute("collections");

	//check if we need to display the "no collection selected" error
    Boolean noCollection = (Boolean) request.getAttribute("no.collection");

    // Obtain DSpace context
    Context context = UIUtil.obtainContext(request);
%>

<dspace:layout style="submission" locbar="off"
               navbar="off"
               titlekey="jsp.submit.select-collection.title"
               nocache="true">

    <h1><fmt:message key="jsp.submit.select-collection.heading"/>
    <dspace:popup page="<%= LocaleSupport.getLocalizedMessage(pageContext, \"help.index\") + \"#choosecollection\"%>"><fmt:message key="jsp.morehelp"/> </dspace:popup></h1>

	
<%  if (collections.length > 0)
    {
%>
	<p><fmt:message key="jsp.submit.select-collection.info1"/></p>

    <form action="<%= request.getContextPath() %>/submit" method="post" onkeydown="return disableEnterKey(event);">
<%
		//if no collection was selected, display an error
		if((noCollection != null) && (noCollection.booleanValue()==true))
		{
%>
					<div class="alert alert-warning"><fmt:message key="jsp.submit.select-collection.no-collection"/></div>
<%
		}
%>  
					<div class="input-group">
					<label for="tcollection" class="input-group-addon">
						<fmt:message key="jsp.submit.select-collection.collection"/>
					</label>
					
					<%-- 26/12/2017 --%>
					<%
						//TAG LIST-COLLECTION
						StringBuffer sb = new StringBuffer();
						
						//Escreve Cabeçalho da tag 'select' e inclui a primeira seleção 'Selecione..'
						sb.append("<select name=\"collection\" class=\"form-control\" id=\"tcollection\">\n");
						sb.append("\t<option value=\"-1\"").append(" selected=\"selected\">");
						sb.append(LocaleSupport.getLocalizedMessage(pageContext, "jsp.submit.start-lookup-submission.select.collection.defaultoption")).append("</option>\n");
						
						//Utilização do Método de Ordenação do Java, para organizar lista de Coleções
						//Conforme nome completo de caminho da Coleção
						
						Arrays.sort(collections, new Comparator<Collection>(){
							@Override
							public int compare(Collection co1, Collection co2){						
								try{
									return CollectionDropDown.collectionPath(co1).compareTo(CollectionDropDown.collectionPath(co2));
								}
								catch(SQLException e){
									return 0;
								}
							}
						});
						
						
						for (Collection coll : collections)
						{
							sb.append("\t<option value=\"").append(coll.getID()).append("\"");
							if ( -1 == coll.getID())
							{
								sb.append(" selected=\"selected\"");
								
							}
							sb.append(">").append(CollectionDropDown.collectionPath(coll)).append("</option>\n");
						}
						
						sb.append("</select>\n");
					%>
					
					<%= sb.toString() %>
					
					<%-- <dspace:selectcollection klass="form-control" id="tcollection" collection="-1" name="collection"/> --%>
					
					<%-- 26/12/2017 --%>
					</div><br/>
            <%-- Hidden fields needed for SubmissionController servlet to know which step is next--%>
            <%= SubmissionController.getSubmissionParameters(context, request) %>

				<div class="row">
					<div class="col-md-4 pull-right btn-group">
						<input class="btn btn-default col-md-6" type="submit" name="<%=AbstractProcessingStep.CANCEL_BUTTON%>" value="<fmt:message key="jsp.submit.select-collection.cancel"/>" />
						<input class="btn btn-primary col-md-6" type="submit" name="<%=AbstractProcessingStep.NEXT_BUTTON%>" value="<fmt:message key="jsp.submit.general.next"/>" />
					</div>
				</div>		
    </form>
<%  } else { %>
	<p class="alert alert-warning"><fmt:message key="jsp.submit.select-collection.none-authorized"/></p>
<%  } %>	
	   <p><fmt:message key="jsp.general.goto"/><br />
	   <a href="<%= request.getContextPath() %>"><fmt:message key="jsp.general.home"/></a><br />
	   <a href="<%= request.getContextPath() %>/mydspace"><fmt:message key="jsp.general.mydspace" /></a>
	   </p>	
</dspace:layout>
