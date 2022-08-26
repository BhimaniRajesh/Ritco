<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Insuramce Report.aspx.cs" Inherits="GUI_UNI_MIS_DOC_Profit_Insuramce_Report" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
 <script language="JavaScript" type="text/javascript" src="./../../Images/CalendarPopup.js"></script>
<script language="javascript" type="text/javascript" src="./../../images/commonJs.js"></script>
<script language="javascript" type="text/javascript">
    var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
	
	function DateCheck()
    {
        var Selection=document.getElementById("ctl00_MyCPH1_radDate_0");
        var txtDateFrom=document.getElementById("ctl00_MyCPH1_txtDateFrom");
        var txtDateTo=document.getElementById("ctl00_MyCPH1_txtDateTo");
        
        if(document.getElementById("ctl00_MyCPH1_radDate_0").checked==true)
        {
            if(txtDateFrom.value=="")
		    {
		        alert("Please enter the From Date")
		        txtDateFrom.focus();
		        return false;
		    }
		    if(txtDateFrom.value!="")
			{
			    if (ValidateForm(txtDateFrom)==false)
				{
					 return false;
				}
			}
		    if(txtDateTo.value=="")
		    {
		        alert("Please enter the To Date")
		        txtDateTo.focus();
		        return false;
		    }
		    if(txtDateTo.value!="")
			{
				if (ValidateForm(txtDateTo)==false)
				{
					 return false;
				}
			}
     
        }
    }

</script>
<br />
<br />
<br />
<br />
    <table align="left" cellspacing="1" class="boxbg" style="width: 9in">
        <tr class="bgbluegrey">
            <td align="center" colspan="7" style="height: 21px">
                <asp:Label ID="lblQry" runat="server" CssClass="blackfnt" Font-Bold="true">Select Sales Criteria </asp:Label>
            </td>
        </tr>
        <tr id="ROWLO" runat="server" style="background-color: white" visible="true">
            <td align="left" colspan="2">
                <asp:Label ID="Label8" runat="server" CssClass="blackfnt" Text="Select RO" Width="100%"></asp:Label>
            </td>
            <td align="left" colspan="5" valign="top">
                <asp:UpdatePanel ID="UP" runat="server">
                    <ContentTemplate>
                        <asp:DropDownList ID="cboRO" runat="server" AutoPostBack="true" OnSelectedIndexChanged="cboRO_SelectedIndexChanged" >
                            <%--<asp:ListItem Value="All" Text="All"></asp:ListItem>--%>
                        </asp:DropDownList>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr style="background-color: white">
            <td align="left" colspan="2">
                <asp:Label ID="Label7" runat="server" CssClass="blackfnt" Text="Select Location"
                    Width="102px"></asp:Label>
            </td>
            <td align="left" colspan="5" valign="top">
                <asp:UpdatePanel ID="updatepanel8" runat="server">
                    <ContentTemplate>
                        <asp:DropDownList ID="cboRO_Lo" runat="server" Mode="Conditional" RenderMode="Inline"
                            Width="102px">
                            <%-- <asp:ListItem Text="All" Value=""></asp:ListItem>--%>
                        </asp:DropDownList>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="cboRO" EventName="SelectedIndexChanged" />
                    </Triggers>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="Label2" runat="server" CssClass="blackfnt" Text="Select Date"></asp:Label>
            </td>
            <td>
                <asp:RadioButtonList ID="radDate" runat="server" CssClass="blackfnt" ValidationGroup="VGDtFromTo"
                    Width="210px">
                    <asp:ListItem Text=" Date Range [dd/mm/yyyy]" Value="0"></asp:ListItem>
                    <asp:ListItem Selected="True" Text=" Last Week (Including Today)" Value="1"></asp:ListItem>
                    <asp:ListItem Text=" Today:" Value="2"></asp:ListItem>
                </asp:RadioButtonList>
            </td>
            <td colspan="5" valign="top">
                <asp:Label ID="lblFrom" runat="server" CssClass="blackfnt" Text=" From: "></asp:Label>
                <asp:TextBox ID="txtDateFrom" runat="Server" MaxLength="10" ValidationGroup="VGDtFromTo"
                    Width="60"></asp:TextBox>
                <a id="anchor1" href="#" name="anchor1" onclick="cal.select(ctl00$MyCPH1$txtDateFrom,'anchor1','dd/MM/yyyy'); return false;">
                    <img border="0" src="./../../images/calendar.jpg" />
                </a>
                <asp:Label ID="lblTo" runat="server" CssClass="blackfnt" Text=" To: "></asp:Label>
                <asp:TextBox ID="txtDateTo" runat="Server" MaxLength="10" ValidationGroup="VGDtFromTo"
                    Width="60"></asp:TextBox>
                <a id="a1" href="#" name="anchor2" onclick="cal.select(ctl00$MyCPH1$txtDateTo,'anchor2','dd/MM/yyyy'); return false;">
                    <img border="0" src="./../../images/calendar.jpg" />
                </a>
            </td>
        </tr>
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Text="Select Type"></asp:Label></td>
            <td>
                <asp:RadioButtonList ID="radBtnType" runat="server" RepeatDirection="Horizontal">
                    <asp:ListItem Selected="True" Value="Y">To Be Receive</asp:ListItem>
                    <asp:ListItem Value="N">To Be Billed </asp:ListItem>
                </asp:RadioButtonList></td>
            <td colspan="5" valign="top">
            </td>
        </tr>
        <tr align="center" bgcolor="white">
            <td colspan="7">
                <asp:Button ID="btnShow" runat="server" OnClick="btnShow_Click" OnClientClick="Javascript: return DateCheck();s"
                    Text="Show" Width="75px" />
            </td>
        </tr>
    </table>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>

