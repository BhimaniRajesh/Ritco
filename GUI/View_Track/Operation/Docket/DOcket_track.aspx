<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DOcket_track.aspx.cs" Inherits="GUI_View_Track_Operation_Docket_DOcket_track" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Track</title>

    <script type="text/javascript" language="Javascript">

var buttontarget=""

function change(e, color){
var el=window.event? event.srcElement: e.target
if (el.tagName=="INPUT"&&el.type=="button")
el.style.backgroundColor=color
}

function jumpto2(url){
if (buttontarget=="")
window.location=url
else if (buttontarget=="_new")
window.open(url)
else
parent[buttontarget].location=url
}


 function OpenPopupWindow_Summary(strDocketNo,strDocketsf)
        {
            alert("Hiii");
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=800,height=600,status=no,left=60,top=50"
            var strPopupURL = "./DocketSummary.aspx?strDckNo="+strDocketNo+"&strDcksf="+ strDocketsf  
            
            winNew = window.open(strPopupURL, "_self", strWinFeature)
        }
        
    function OpenPopupWindow_OPNLIFECYCLE(strDocketNo,strDocketsf)
        {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=800,height=600,status=no,left=60,top=50"
            var strPopupURL = "./opnLifecycle.aspx?strDckNo="+strDocketNo+"&strDcksf="+ strDocketsf  
            
            winNew = window.open(strPopupURL, "_self", strWinFeature)
        }
   function OpenPopupWindow_FINLIFECYCLE(strDocketNo,strDocketsf)
        {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=800,height=600,status=no,left=60,top=50"
            var strPopupURL = "./FinLifeCycle.aspx?strDckNo="+strDocketNo+"&strDcksf="+ strDocketsf  
            
            winNew = window.open(strPopupURL, "_self", strWinFeature)
        }


    </script>

    <link rel="stylesheet" type="text/css" href="../../../images/style.css" />
    <link rel="stylesheet" type="text/css" href="./ajaxtabs/ajaxtabs.css" />

    <script type="text/javascript" language="javascript" src="./ajaxtabs/ajaxtabs.js"></script>

</head>
<body>

                   
    <%-- <ul id="countrytabs" runat="server"  class="shadetabs">
                <li class="selected"><a href="Javascript:OpenPopupWindow_Summary('<%=str_dockno%>','<%=str_docksf%>')"
                    rel="ajaxcontentarea">Summary</a></li>
                <li><a href="Javascript:OpenPopupWindow_OPNLIFECYCLE('<%=str_dockno%>','<%=str_docksf%>')"
                    rel="ajaxcontentarea">Life Cycle - Operations</a></li>
                <li><a href="Javascript:OpenPopupWindow_FINLIFECYCLE('<%=str_dockno%>','<%=str_docksf%>')"
                    rel="ajaxcontentarea">Life Cycle - Finance</a></li>
            </ul>--%>
    <%--<ul id="maintab"  class="shadetabs">
<li class="selected"><a href="./TrackTYPE.aspx?strDckNo=<%=str_dockno%>&strDcksf=<%=str_docksf%>&TYP=S"  rel="ajaxcontentarea">summary</a></li>
<li><a href="./TrackTYPE.aspx?strDckNo=<%=str_dockno%>&strDcksf=<%=str_docksf%>&TYP=O" rel="ajaxcontentarea">View & Print</a></li>
<li><a href="./TrackTYPE.aspx?strDckNo=<%=str_dockno%>&strDcksf=<%=str_docksf%>&TYP=F"  rel="ajaxcontentarea">Life Cycle - Operations</a></li>

</ul>--%>
    <ul id="countrytabs" runat="server" class="shadetabs">
        <li><a href="./DocketSummary.aspx?strDckNo=<%=str_dockno%>&strDcksf=<%=str_docksf%>"
            rel="#iframe" style=" height:500px;" class="selected">Summary</a></li>
        <li ><a href="./OpnLifeCycle.aspx?strDckNo=<%=str_dockno%>&strDcksf=<%=str_docksf%>"
            rel="#iframe" style="height: auto">Life Cycle - Operation</a></li>
        <li><a href="./FinLifeCycle.aspx?strDckNo=<%=str_dockno%>&strDcksf=<%=str_docksf%>"
            rel="#iframe" style="height: auto">Life Cycle - Finance</a></li>
        <li><a href="./PODPFM_track.aspx?strDckNo=<%=str_dockno%>&strDcksf=<%=str_docksf%>"
            rel="#iframe" style="height: auto">POD/PFM Track</a></li>
        <li><a href="./PODPFM_track.aspx?strDckNo=<%=str_dockno%>&strDcksf=<%=str_docksf%>"
              rel="ajaxcontentarea" >Movement</a></li>
    </ul>
    <div id="ajaxcontentarea" class="contentstyle" style="border: 1px solid gray; width: 850px;
        height: 800; margin-bottom: 1em; padding: 10px">
       
        <p>
            <b></b>
        </p>
    </div>
    <%--<ul id="countrytabs" class="shadetabs">
  <li><a href="TrackTYPE.aspx?strDckNo=<%=str_dockno%>&strDcksf=<%=str_docksf%>&TYP=S" rel="countrycontainer" class="selected">Tab 1</a></li>
  <li><a href="TrackTYPE.aspx?strDckNo=<%=str_dockno%>&strDcksf=<%=str_docksf%>&TYP=O" rel="countrycontainer" class="selected">Tab 2</a></li>
    <li><a href="TrackTYPE.aspx?strDckNo=<%=str_dockno%>&strDcksf=<%=str_docksf%>&TYP=F" rel="countrycontainer" class="selected">Tab 3</a></li>
</ul>

<div id="countrycontainer" class="contentstyle" style="border:1px solid gray; width:850px; height:800; margin-bottom: 1em; padding: 10px">

</div>--%>

    <script type="text/javascript" language="Javascript">

debugger
var countries=new ddajaxtabs('countrytabs', 'ajaxcontentarea')
countries.setpersist(true)
countries.setselectedClassTarget('link') //"link" or "linkparent"
countries.init()



    </script>

</body>

</html>
