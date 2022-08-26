<%@ Page Language="C#" AutoEventWireup="true" CodeFile="THCTrack.aspx.cs" Inherits="GUI_Tracking_THCTrack" %>

<%@ Register Src="TabsView.ascx" TagName="TabsView" TagPrefix="uc1" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
<title>Untitled Page</title>
    <link href="../../GUI/images/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
<form id="form1" runat="server">
<asp:ScriptManager ID="scmn1" runat="server" EnableViewState="true" EnableScriptComponents="true"></asp:ScriptManager>
<div>

<%-- Tab2Title="View & Print"
 Tab5Title="Movement"
 Tab2Title="Movemet"
                        Tab6Title="Exception"--%>
<uc1:TabsView ID="TabsView1"  align="centre"  runat="server"  OnTabChanged="TabsView1_OnTabChanged" 
                        Tab1Title="    Summary   " 
                        
                       
                       >
                      
                        
                        
                        <Tab1>
                            <br />
                          
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server" RenderMode="Inline"   UpdateMode="Conditional">
                                 <ContentTemplate>
                                    <table  align="center" border="0" cellspacing="1" cellpadding="3" style="width: 90%" >
                                       
                                        <tr   bgcolor="white">
                                            <td align="center"  colspan="9"><font class=blackfnt><!-- #include file="./THC_Summary.aspx"--></font></td>
                                             
                                        </tr>
                                         
                                      </table>
                                     
                                     </ContentTemplate>
                                     
                                  </asp:UpdatePanel>
                        </Tab1>
                        
                       
                        
                        <Tab2>
                         <br /><asp:UpdatePanel ID="UpdatePanel3" runat="server" RenderMode="Inline"  UpdateMode="Conditional">
                                <Triggers>
                                            </Triggers> <ContentTemplate>
                                   <table  align="center" border="0" cellspacing="1" cellpadding="3" style="width: 90%" >
                                       
                                        <tr   bgcolor="white">
                                            <td align="center"  colspan="9"><font class=blackfnt><!-- #include file="./THC_Movement.aspx"--></font></td>
                                             
                                        </tr>
                                         
                                      </table>
                                     </ContentTemplate>
                                  </asp:UpdatePanel></Tab2>
                                  </uc1:TabsView>
                  
</div>

</form>
</body>
</html>
