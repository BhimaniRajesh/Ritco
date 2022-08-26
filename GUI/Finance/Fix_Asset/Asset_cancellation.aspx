<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    Trace="false" CodeFile="Asset_cancellation.aspx.cs" Inherits="GUI_Finance_Fix_Asset_aaaaa" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="JavaScript" type="text/javascript">
  
   function nwOpen()
        {
            window.open("popupLoc.aspx","pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
        
    </script>

    <table style="width: 1100px">
        <tr>
            <td align="left">
                <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                    <b>Finance</b></font></a> <b>&gt; </b><a><font class="blklnkund"><b>Fix Asset Management</b></font></a>
                <b>&gt; </b><font class="bluefnt"><b>Asset Cancellation</b></font>
            </td>
            <td align="right">
                <a href="javascript:window.history.go(-1)" title="back">
                    <img src="../../images/back.gif" border="0" alt="" /></a>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <div align="left" style="width: 9.5in;">
        <asp:UpdatePanel ID="UP1" runat="Server">
            <ContentTemplate>
                <table cellspacing="1" style="width: 90%" class="boxbg" border="0">
                    <tr class="bgbluegrey">
                        <td colspan="3" align="center" style="height: 21px">
                            <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">
                                        Enter Asset No for Cancellation
                            </asp:Label>
                        </td>
                    </tr>
               
                    <tr style="background-color: white">
                        <td align="left" style="width: 2in">
                            <asp:Label ID="Label2" CssClass="blackfnt" Text="Enter Asset No." runat="server" Width="113px"></asp:Label>
                        </td>
                        <td align="left" colspan="2" valign="top" style="height: 24px;">
                            <asp:TextBox ID="txtven" runat="server" Width="100px"></asp:TextBox> 
                        </td>
                    </tr>
                   
                </table>
                <br />
                <div style="width: 9.5in" align="center">
                    <asp:Button ID="Button3" runat="server" Text="Submit" Width="150" OnClick="Button3_Click" />
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 99;">
    </div>
</asp:Content>
