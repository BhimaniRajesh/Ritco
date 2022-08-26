<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="AgentBill_Step1.aspx.cs" Inherits="GUI_Octroi_AgentBill_Step1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <%--THIS TWO FILES ARE FOR CALENDAR CONTROL--%>

    <script language="javascript" type="text/javascript" src="./../../images/commonJs.js"></script>

    <script language="javascript" type="text/javascript" src="./../../images/CalendarPopup.js"></script>

    <script language="JavaScript" type="text/javascript">
	var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
    </script>

    <%--THIS FILE IS USED FOR DATEVALIDATION FUNCTION--%>

    <script language="javascript" type="text/javascript" src="JS/ViewPrint.js"></script>

    <script language="javascript" type="text/javascript">

            // LIABRARY FUNCTIONALITY   
var loccodeval="<%=Locationstr%>";
        
function locCheck(obj)
{
   // alert(loccodeval)
       if (obj.value!="")
        {
            
            if(obj.value.length<3)
  			    {
  				    alert("Invalid Location code Length")
  				    obj.focus();
				    return false;
  			    }
            if(loccodeval.indexOf(obj.value)==-1 )
  			    {
  				    alert("Invalid Location code")
  				    obj.focus();
				    return false;
  			    }
  	    }
}



function requireCheck()
{
    var optbtn=document.getElementById("ctl00$MyCPH1$radDate");
    
    if(optbtn.value=="0")
    {
        var date1=document.getElementById("ctl00$MyCPH1$txtDateFrom");
        var date2=document.getElementById("ctl00$MyCPH1$txtDateTo");
        
        if(!isValidDate(date1.value,"From"))
            return false;
        if(!isValidDate(date2.value,"To"))
            return false;
    }

    var txtloc=document.getElementById("ctl00$MyCPH1$txtoctloc");
        if(txtloc.value=="")
            {
                alert("Enter the Location Properly..........");
                txtloc.focus();
                return false;
            }
}


function locCheck(obj)
{
   // alert(loccodeval)
       if (obj.value!="")
        {
            
            if(obj.value.length<3)
  			    {
  				    alert("Invalid Location code Length")
  				    obj.focus();
				    return false;
  			    }
            if(loccodeval.indexOf(obj.value)==-1 )
  			    {
  				    alert("Invalid Location code")
  				    obj.focus();
				    return false;
  			    }
  	    }
}
 
   

    </script>

    <%--
=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=
                            Second Page in Vewing Octroy Bills(voucher)
=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=
    --%>
    <div align="center">
        <table style="width: 100%">
            <tr>
                <td align="left" colspan="3">
                    <asp:Label ID="lblWelcome" runat="server" Text="View & Print Octrio Bills" CssClass="blackfnt"
                        Font-Bold="true"></asp:Label>
                    <hr align="center" size="1" color="#8ba0e5" />
                </td>
            </tr>
        </table>
        <br />
        <%--Back Link To First Page in Viewing Octroy Bills--%>
        <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td align="right" style="height: 33px">
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img alt="" border="0" src="../../images/back.gif" /></a>
                </td>
            </tr>
        </table>
        <br />
        <%-- Main Table --%>
        <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg"
            width="85%">
            <tr class="bgbluegrey">
                <td align="center" colspan="3">
                    <font class="blackfnt">Enter Bill No for View & Print</font>
                </td>
            </tr>
            <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                <td valign="top" align="right">
                    <font class="blackfnt">Bill Number :</font>
                </td>
                <td style="font-size: 12pt; font-family: Times New Roman" valign="top" align="left">
                    &nbsp;<asp:TextBox ID="txtbillno" runat="server" Style="left: 0px; position: relative;
                        top: 0px" ValidationGroup="billnogroup"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="billnogroup"
                        ControlToValidate="txtbillno" runat="server" ErrorMessage="Enter the Location Properly......"></asp:RequiredFieldValidator>
                </td>
                <td valign="top" align="left">
                    <asp:Button runat="server" ID="btnsubmit1" Text="Submit" ValidationGroup="billnogroup"
                        OnClick="btnsubmit1_Click" />
                </td>
            </tr>
            <tr bgcolor="#ffffff">
                <td align="center" colspan="3">
                    <font class="blackfnt"><b>OR</b></font>
                </td>
            </tr>
            <tr class="bgbluegrey">
                <td align="center" colspan="3">
                    <font class="blackfnt">Select Bills for View & Print</font>
                </td>
            </tr>
            <%--  from heree--%>
            <tr bgcolor="#ffffff">
                <td align="right" style="font-size: 12pt; font-family: Times New Roman">
                    <font class="blackfnt">Enter Location : </font>
                </td>
                <td align="left" colspan="2">
                    <asp:TextBox ID="txtoctloc" runat="server" Style="left: 0px; position: relative;
                        top: 0px" Width="60px"></asp:TextBox>
                    <input type="button" id="btnPopUp" value="Go" name="custpup12" runat="server" />
                </td>
            </tr>
            <tr bgcolor="#ffffff">
                <td align="right" style="font-size: 12pt; font-family: Times New Roman">
                    <font class="blackfnt">Select Octroi Agent : </font>
                </td>
                <td bgcolor="#ffffff" align="left" colspan="2">
                    <asp:DropDownList runat="server" ID="cmbselcust" Width="150px">
                        <asp:ListItem>--All--</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr class="bgbluegrey">
                <td align="center" colspan="3">
                    <font class="blackfnt">Select Bill Generation Date Range</font>
                </td>
            </tr>
            <tr bgcolor="#ffffff">
                <td align="right">
                    <asp:Label ID="lblDateRange1" runat="server" CssClass="blackfnt" Font-Bold="False"
                        Width="120px">Select Bill Date : </asp:Label>
                </td>
                <td colspan="2">
                    <table cellpadding="0" cellspacing="0" class="boxbg" border="0">
                        <tr style="background-color: white">
                            <td align="left" valign="top" class="blackfnt">
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server"   UpdateMode="Conditional" RenderMode="Inline">
                                    <ContentTemplate>
                                        <asp:RadioButtonList ID="radDate" runat="server" AutoPostBack="true" CssClass="blackfnt"
                                            OnSelectedIndexChanged="radDate_OnSelectedIndexChange" ValidationGroup="VGDtFromTo"
                                            Width="210px">
                                            <asp:ListItem Selected="True" Text=" Date Range " Value="0"></asp:ListItem>
                                            <asp:ListItem Text=" Last Week (Including Today)" Value="1"></asp:ListItem>
                                            <asp:ListItem Text=" Today:" Value="2"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                            <td align="left" valign="top" class="blackfnt">
                                <asp:UpdatePanel ID="UpdatePanel2" runat="server"  UpdateMode="Conditional" RenderMode="Inline">
                                    <ContentTemplate>
                                        <asp:Label ID="lblFrom" runat="server" CssClass="blackfnt" Text=" From: "></asp:Label>
                                        <asp:TextBox ID="txtDateFrom" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                        <a href="#" onclick="cal.select(ctl00$MyCPH1$txtDateFrom,'anchor1','dd/MM/yyyy'); return false;"
                                            name="anchor1" id="a1">
                                            <img src="./../../images/calendar.jpg" alt="calendar.jpg"
                                                border="0">
                                        </a>(dd/mm/yyyy)
                                        <asp:Label ID="lblTo" runat="server" CssClass="blackfnt" Text=" To: "></asp:Label>
                                        <asp:TextBox ID="txtDateTo" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                        <a href="#" onclick="cal.select(ctl00$MyCPH1$txtDateTo,'anchor11','dd/MM/yyyy'); return false;"
                                            name="anchor11" id="anchor11">
                                            <img src="./../../images/calendar.jpg" alt="calendar.jpg"
                                                border="0"></a>(dd/mm/yyyy)
                                        <br />
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="radDate" EventName="SelectedIndexChanged" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr bgcolor="#ffffff">
                <td align="center" colspan="3">
                    <asp:Button runat="server" ID="btnsubmit2" Text="Submit" OnClick="btnsubmit2_Click" />
                </td>
            </tr>
        </table>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 99;">
    </div>
</asp:Content>
