<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Bill_MR_Cancellation_step_1.aspx.cs" Inherits="GUI_Finance_Bill_MR_Cancellation_Bill_MR_Cancellation_step_1" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"> </script>
<script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>
<script language="javascript" type="text/javascript">
    var cal = new CalendarPopup("Div1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
	  var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");
      var FinYear="<%=Session["FinYear"]%>"
	  var FinYear_to=parseInt(FinYear)+1
		
		if(FinYear_to<10)
		{
		FinYear_to="0"+FinYear_to
		}
		var FinYear_fromdate="01/04/"+FinYear
		var FinYear_todate="31/03/"+FinYear_to
		var Sle_finyear=FinYear+"-"+FinYear_to
        var Frm_name="ctl00$MyCPH1$"
        function Check_Submit()
        {
            if(document.getElementById(Frm_name+"txtBillMrNo").value=="")
            {
                if(document.getElementById(Frm_name+"txtDateFrom").value=="")
                {
                    alert("Plz Enter From Date ")
                    document.getElementById(Frm_name+"txtDateFrom").focus()
                    return false;
                }
                if(document.getElementById(Frm_name+"txtDateTo").value=="")
                {
                    alert("Plz Enter To Date ")
                    document.getElementById(Frm_name+"txtDateTo").focus()
                    return false;
                }
                
            }
            if(document.getElementById(Frm_name+"ddrbillmrtype").value == "")
                {
                     alert("Plz Select Bill/MR Type ")
                    document.getElementById(Frm_name+"ddrbillmrtype").focus()
                    return false;
                }
        }
</script>        
    <br />
        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
            <ProgressTemplate>
                <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px; -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                    <tr>
                        <td align="right"><img src="../../images/loading.gif" alt="" /></td>
                        <td><font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font></td>
                    </tr>
                </table>
                <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px; background-color: #FFFFFF;
                    width: 100%; height: 100%; filter: Alpha(Opacity=50); opacity: .50; -moz-opacity: .50;"
                    runat="server">
                    <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                        left: 50%;" ID="Panel2" runat="server">
                    </asp:Panel>
                </asp:Panel>
            </ProgressTemplate>
        </asp:UpdateProgress>
    <br />
    <div align="left" style="width: 9.5in;">
        <center>
            <asp:UpdatePanel ID="UP1" runat="Server">
                <ContentTemplate>
                    <table cellspacing="1" style="width: 90%; height: 263px;" border="0">
                        <tr align="center">
                            <td style="height: 324px" align="center" colspan="3">
                                <table cellspacing="1" style="width: 90%" class="boxbg" border="0">
                                    <tr class="bgbluegrey">
                                        <td colspan="3" align="center" style="height: 21px">
                                            <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">
                                                Enter Bill / MR For Cancellation
                                            </asp:Label>
                                        </td>
                                    </tr>
                                    <tr style="background-color: white">
                                        <td align="left"  style="height: 21px">
                                            <asp:Label ID="lblcheckboxselection" runat="server" Text="Please Select Bill Or MR :"></asp:Label>
                                        </td>
                                        <td colspan="2" align="left" style="height: 21px">
                                            <asp:RadioButton ID="radbillselection" Text="Bill" runat="server" Checked="true" GroupName="billmrgroup" OnCheckedChanged="showDetails" AutoPostBack="true" />
                                            &nbsp;&nbsp;
                                            <asp:RadioButton ID="radmrselection" Text="MR" runat="server" GroupName="billmrgroup" OnCheckedChanged="showDetails" AutoPostBack="true" />
                                        </td>
                                    </tr>
                                    <tr style="background-color: white">
                                        <td align="left" style="height: 25px; width: 100px;">
                                            <asp:Label ID="lblbillmrno" CssClass="blackfnt" Text="Enter Bill No. :" runat="server"
                                                Width="122px"></asp:Label>
                                        </td>
                                        <td align="left" colspan="2" style="height: 25px; width: 100px;">
                                            <asp:TextBox ID="txtBillMrNo" runat="server"></asp:TextBox>
                                        </td>
                                        <%--<td align="left" valign="top" style="height: 25px"></td>--%>
                                    <tr style="background-color: white">
                                        <td colspan="3" align="center" style="height: 21px">
                                            <asp:Label ID="Label1" CssClass="blackfnt" Font-Bold="true" runat="server">
                                                OR
                                            </asp:Label>
                                        </td>
                                    </tr>
                                    <tr style="background-color: white">
                                    <td align="left" style="height: 25px; width: 100px;">
                                        <asp:Label ID="lblbillmrtype" CssClass="blackfnt" Text="Bill Type:" runat="server"
                                            Width="122px"></asp:Label>
                                    </td>
                                    <td align="left" style="height: 25px; width: 100px;" colspan="2">
                                       <asp:DropDownList ID="ddrbillmrtype" runat="server" CssClass="blackfnt" AutoPostBack="true" Width="100px">
                                       </asp:DropDownList>
                                    </td>
                                    </tr>
                                    <tr class="bgbluegrey">
                                        <td colspan="3" align="center" style="height: 21px">
                                            <asp:Label ID="Label5" CssClass="blackfnt" Font-Bold="true" runat="server">
                                                Select Date 
                                            </asp:Label>
                                        </td>
                                    </tr>
                                    <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                        <td valign="top" align="left">
                                            <asp:Label ID="Label6" CssClass="blackfnt" Text="Select Date Range" runat="server"
                                                Width="145px"></asp:Label>
                                        </td>
                                        <td align="left" style="width: 259px" valign="top">
                                            <asp:RadioButtonList ID="radDate" runat="server" ValidationGroup="VGDtFromTo" CssClass="blackfnt"
                                                AutoPostBack="true" OnSelectedIndexChanged="radDate_SelectedIndexChanged" RepeatColumns="1"
                                                Width="244px">
                                                <asp:ListItem  Value="0" Text=" Date Range [dd/mm/yyyy]"></asp:ListItem>
                                                <asp:ListItem Value="1" Text=" Last Week (Including Today)"></asp:ListItem>
                                                <asp:ListItem Selected="True" Value="2" Text=" Today:"></asp:ListItem>
                                                <asp:ListItem Value="3" Text=" Till Date:"></asp:ListItem>
                                            </asp:RadioButtonList></td>
                                        <td valign="top" align="left" style="width: 359px">
                                            <asp:Label ID="lblFrom" CssClass="blackfnt" runat="server" Text=" From: "></asp:Label>
                                            <asp:TextBox ID="txtDateFrom" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                            <a href="#" onclick="cal.select(ctl00_MyCPH1_txtDateFrom, 'alnkDateFrom', 'dd/MM/yyyy'); return false;"
                                                id="alnkDateFrom">
                                                <img src="../../images/calendar.jpg" border="0" alt="" />
                                            </a>
                                            <asp:Label ID="lblTo" CssClass="blackfnt" runat="server" Text=" To: "></asp:Label><asp:TextBox
                                                ID="txtDateTo" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                            <a href="#" onclick="cal.select(ctl00_MyCPH1_txtDateTo, 'a1', 'dd/MM/yyyy'); return false;"
                                                id="a1">
                                                <img src="../../images/calendar.jpg" border="0" alt="" />
                                                <br />
                                                <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Date Range Must Be 1 month Only"
                                                    OnServerValidate="daterange"></asp:CustomValidator>
                                                <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtDateFrom"
                                                            ErrorMessage="Date From Can Not Be Blank"></asp:RequiredFieldValidator>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtDateTo"
                                                            ErrorMessage="Date To Can Not Be Blank"></asp:RequiredFieldValidator>--%>
                                        </td>
                                    </tr>
                            </td>
                        </tr>
                        
                        <tr style="background-color: white">
                            <td colspan="4">
                                <asp:Button ID="Button1" runat="server" OnClick="submit1_Click" Text="Submit" />
                            </td>
                        </tr>
                    </table>
                    <div id="Div1" style="position: absolute; visibility: hidden; background-color: white;
                        z-index: 99;">
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </center>
    </div>
</asp:Content>

