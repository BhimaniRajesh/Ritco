<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="RouteMasterEdSelect.aspx.cs" Inherits="GUI_admin_RouteMaster_RouteMasterEdSelect"
    Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">
    
        function chkVal()
        {
            if(document.getElementById("ctl00_MyCPH1_txtRutCd").value == "" && document.getElementById("ctl00_MyCPH1_ddRutSelect").value == "--Select--" ) 
            {
                alert("Do not keep blank");
                return false;
            } 
            else if(document.getElementById("ctl00_MyCPH1_txtRutCd").value != "" && document.getElementById("ctl00_MyCPH1_ddRutSelect").value != "--Select--") 
            {
                alert("Please select only one");
                return false;
            }
            else
            {
                return true;
            }
        }
        
    </script>
    <br />
    <div align="left" style="width: 10in">
        <table border="0" cellpadding="0" cellspacing="0" style="width: 940px">
            <tr>
                <td align="left">
                    <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                        <b>Administrator</b></font></a> <b>&gt; </b><a href="../operations.aspx"><font class="blklnkund">
                            <b>Operations</b></font></a> <b>&gt; </b><font class="bluefnt"><b>Route Master</b></font>
                </td>
                <td align="right">
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img src="../../images/back.gif" border="0" alt="" /></a>
                </td>
            </tr>
        </table>
    </div>
    <br />
    <div align="left" style="width: 10in">
        <asp:UpdatePanel ID="up1" runat="server">
            <ContentTemplate>
                <table border="0" class="boxbg" cellspacing="1" cellpadding="2" width="70%">
                    <tr class="bgbluegrey">
                        <td align="center" colspan="2">
                            <font class="blackfnt"><b>Query Route Master for Edit</b></font>
                        </td>
                    </tr>
                    <tr bgcolor="#FFFFFF">
                        <td align="left" width="30%">
                            <font class="blackfnt">Route Code :</font>
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtRutCd" runat="server" Width="71px"></asp:TextBox></td>
                    </tr>
                    <tr bgcolor="#FFFFFF">
                        <td align="center" colspan="2">
                            <font class="blackfnt"><b>OR</b></font>
                        </td>
                    </tr>
                    <%--<tr bgcolor="#FFFFFF">
			<td align="left" width="30%">
				<font class="blackfnt">Location Code  in the Route:</font>
			</td>

			<td align="left">
                <asp:TextBox ID="txtLocCd" runat="server" Width="72px"></asp:TextBox></td>
		</tr>

		<tr bgcolor="#FFFFFF">
			<td align="center" colspan="2">
				<font class="blackfnt"><b>OR</b></font>
			</td>
		</tr>--%>
                    <tr bgcolor="#ffffff">
                        <td class="blackfnt" align="left" width="30%">
                            Route Mode</td>
                        <td align="left">
                            <asp:DropDownList ID="CmbRouteMode" runat="server" Width="174px" AutoPostBack="True"
                                OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                                <asp:ListItem>All</asp:ListItem>
                                <asp:ListItem Value="A">Air</asp:ListItem>
                                <asp:ListItem Value="S">Road</asp:ListItem>
                                <asp:ListItem Value="R">Rail</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr bgcolor="#FFFFFF">
                        <td align="left" width="30%">
                            <font class="blackfnt">Select Route:</font>
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddRutSelect" runat="server" Width="174px">
                            </asp:DropDownList></td>
                    </tr>
                    <tr bgcolor="#FFFFFF">
                        <td align="center" colspan="2">
                            <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClientClick="return chkVal()"
                                OnClick="btnSubmit_Click" />
                                <asp:Button ID="Button1" runat="server" Text="Listing" PostBackUrl="~/GUI/admin/RouteMaster/ListAll.aspx"/>
                                </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
