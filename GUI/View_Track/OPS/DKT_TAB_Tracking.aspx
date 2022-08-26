<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DKT_TAB_Tracking.aspx.cs"
    Inherits="GUI_View_Track_Operation_DKT_TAB_Tracking" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="X-UA-Compatible" content="IE=egde" />
    <title>Tracking</title>
    <style type="text/css">
    /*
=================================================
Tab View Tyle - START
Update By : Harshad
Updated On : 03 April 09
=================================================
*/
.menuTabs
{
    position:relative;    
    top:1px;
    left:20px;
    
}
.tab
{
    border:Solid 1px #8ba0e5;
    border-bottom:Solid 1px #8ba0e5;    
    color:Black;
    padding:6px 10px;
    background-color:white;
    FONT-WEIGHT: 500;
    FONT-SIZE: 11px;    
    FONT-WEIGHT:bold;
    FONT-FAMILY: verdana;
    TEXT-DECORATION: none;
    height :21px;
}
.tab a:hover { color: blue; text-decoration:none;FONT-WEIGHT:bold;
    background-color:lightsteelblue; padding:6px 10px;  } 
.selectedTab
{
    border:Solid 1px #8ba0e5;
    border-bottom:none;
    padding:6px 10px;
    color:#000000;
    FONT-WEIGHT:bold;
    background-color:lightsteelblue;    
    FONT-SIZE: 11px;    
    FONT-FAMILY: verdana;
    TEXT-DECORATION: none
}
.selectedTab a:hover { color: blue; text-decoration:none; } 

.tabBody
{
    border:Solid 1px #8ba0e5;
    padding:6px;
    background-color:white;
    FONT-WEIGHT: 500;
    FONT-SIZE: 11px;    
    FONT-FAMILY: verdana;
    TEXT-DECORATION: none
}


/*
=================================================
Tab View Style - END
=================================================
*/
    </style>
</head>
<body  style:"leftmargin:0;topmarin:0" >
    <form id="form1" runat="server">
        <div>
          
                      
                           <asp:ScriptManager ID="ScriptManager" runat="server" EnablePartialRendering="true"></asp:ScriptManager>
<rsweb:ReportViewer ExportContentDisposition="AlwaysAttachment" ID="ReportViewer1"
                                runat="server" Font-Names="Verdana" CssClass="blackfnt" ShowFindControls="false"  
                                Height="600px" ShowParameterPrompts="false" ShowBackButton="false" ShowPromptAreaButton="true"
                                ToolBarItemHoverBackColor="Aqua" ToolBarItemPressedHoverBackColor="BlueViolet"
                                ProcessingMode="Remote" Width="100%">
                                <ServerReport DisplayName="Tracking Result" >
                                </ServerReport>
                            </rsweb:ReportViewer>
                       
        </div>
    </form>
</body>
</html>
