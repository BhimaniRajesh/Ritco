<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Query.aspx.cs" Inherits="GUI_UNI_MIS_Route_summary_Query" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="JavaScript" src="./../../Images/CalendarPopup.js"></script>

    <script type="text/javascript" language="javascript" src="./../../images/commonJs.js"></script>

    <script type="text/javascript" language="JavaScript">
var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
	
	
	function DateCheck()
{
     //var Selection=document.getElementById("ctl00_MyCPH1_radDate_0");
     var txtDateFrom=document.getElementById("ctl00_MyCPH1_txtDateFrom");
     var txtDateTo=document.getElementById("ctl00_MyCPH1_txtDateTo");
     var DL_Acc=document.getElementById("ctl00_MyCPH1_DLL_ACC"); 
     // var txtcustcd=document.getElementById("ctl00_MyCPH1_txtcustcd");
      // var txtvendcd=document.getElementById("ctl00_MyCPH1_txtvendcd");
      //  var DLLOrder=document.getElementById("ctl00_MyCPH1_DLLOrder");
     
    
        if(DL_Acc.value=="All")
		 {
		  alert("Please Select Route")
		  DL_Acc.focus();
		  return false;
		 }
    
   
     if (document.getElementById("ctl00_MyCPH1_radDate_0").checked==true)
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
    <table id="Table1" runat="server" cellpadding="3" cellspacing="1" style="width: 8.5in;">
        <tr>
            <td>
                <center>
                    <asp:UpdatePanel ID="UpdatePanel5"  UpdateMode="Conditional" runat="server">
                        <ContentTemplate>
                            <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                                <ProgressTemplate>
                                    <div id="progressArea">
                                        <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="blackfnt" Font-Bold="true"></asp:Label>
                                        <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                                    </div>
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </center>
            </td>
        </tr>
        <tr>
            <td>
                <table cellspacing="1" style="width: 10.0in" class="boxbg" border="0">
                   
                    
                      <tr align="center"  class="bgbluegrey">
                <td  colspan="6">
               <font class="blackfnt">Route Summary Criteria</font>
                 </td>
            </tr>
                    
                       <tr style="background-color: white">
                                <td align="left">
                                    <asp:Label ID="Label2" CssClass="blackfnt" Text="Select Date" runat="server"></asp:Label>
                                </td>
                                <td>
                                    <asp:RadioButtonList ID="radDate" runat="server" ValidationGroup="VGDtFromTo" CssClass="blackfnt"
                                        Width="210px">
                                        <asp:ListItem Selected="True" Value="0" Text=" Date Range [dd/mm/yyyy]"></asp:ListItem>
                                        <asp:ListItem Value="1" Text=" Last Week (Including Today)"></asp:ListItem>
                                        <asp:ListItem Value="2" Text=" Today:"></asp:ListItem>
                                        <%-- <asp:ListItem Value="3" Text=" Till Date:"></asp:ListItem>--%>
                                    </asp:RadioButtonList>
                                </td>
                                <td valign="top" colspan="4">
                                    <asp:Label ID="lblFrom" CssClass="blackfnt" runat="server" Text=" From: "></asp:Label>
                                    <asp:TextBox ID="txtDateFrom" runat="Server" ValidationGroup="VGDtFromTo" Width="60"
                                        MaxLength="10"></asp:TextBox>
                                    <a href="#" onclick="cal.select(ctl00$MyCPH1$txtDateFrom,'anchor1','dd/MM/yyyy'); return false;"
                                        name="anchor1" id="anchor1">
                                        <img src="./../../images/calendar.jpg" border="0"></img>
                                    </a>
                                    <asp:Label ID="lblTo" CssClass="blackfnt" runat="server" Text=" To: "></asp:Label>
                                    <asp:TextBox ID="txtDateTo" runat="Server" ValidationGroup="VGDtFromTo" Width="60"
                                        MaxLength="10"></asp:TextBox>
                                    <a href="#" onclick="cal.select(ctl00$MyCPH1$txtDateTo,'anchor2','dd/MM/yyyy'); return false;"
                                        name="anchor2" id="a1">
                                        <img src="./../../images/calendar.jpg" border="0"></img>
                                    </a>
                                </td>
                            </tr>
                             <tr id="ACCRO" runat="server" style="background-color: white">
                        <td  colspan="1" align="left" style="height: 21px">
                            <asp:Label ID="Label7"  CssClass="blackfnt" Text="Select Accounts" runat="server"></asp:Label>
                        </td>
                        <td colspan="5" align="left" style="height: 21px">
                             <asp:DropDownList ID="DLL_ACC"  runat="server" >
                             <asp:ListItem Value="All" Text="All" Selected="True"  ></asp:ListItem>
                                    </asp:DropDownList>
                        </td>
                       
                        </tr>
                        <tr id="Tr1" runat="server" style="background-color: white">
                        <td  colspan="1" align="left" style="height: 21px">
                            <asp:Label ID="Label1"  CssClass="blackfnt" Text="Select Vehicle" runat="server"></asp:Label>
                        </td>
                        <td colspan="5" align="left" style="height: 21px">
                             <asp:DropDownList ID="DLLVehicle"  runat="server" >
                             <asp:ListItem Value="All" Text="All" Selected="True"  ></asp:ListItem>
                                    </asp:DropDownList>
                        </td>
                       
                        </tr>
                    <tr runat="server" style="background-color: white">
                        <td align="left" colspan="1" style="height: 21px">
                            <asp:Label ID="Label3" runat="server" CssClass="blackfnt" Text="Select Vendor"></asp:Label></td>
                        <td align="left" colspan="5" style="height: 21px"><asp:DropDownList ID="DDLVendor"  runat="server" >
                            <asp:ListItem Selected="True" Text="All" Value="All"></asp:ListItem>
                        </asp:DropDownList></td>
                    </tr>
                    
                       <tr align="center" bgcolor="white">
                <td  colspan="6">
                <asp:RadioButtonList   ID="rpttyp" RepeatDirection="horizontal" CssClass="blackfnt"  runat="server">
                <asp:ListItem Selected="True"  Text="Route Wise" Value="1"></asp:ListItem>
                <asp:ListItem   Text="Location Wise" Value="2"></asp:ListItem>
                 <asp:ListItem   Text="Customer Wise" Value="3"></asp:ListItem>
                 <%-- <asp:ListItem   Text="Employee Wise" Value="4"></asp:ListItem>
                  <asp:ListItem   Text="Account Wise" Value="5"></asp:ListItem>--%>
                   
                </asp:RadioButtonList>
                 </td></tr>    
                 
             <tr align="center" bgcolor="white">
                <td  colspan="6"><asp:RadioButtonList    ID="rptfrt" RepeatDirection="horizontal" CssClass="blackfnt"  runat="server">
                <asp:ListItem Selected="True"  Text="HTML Formate" Value="1"></asp:ListItem>
                <asp:ListItem   Text="XLS Formate" Value="2"></asp:ListItem>
               <%-- <asp:ListItem   Text="CSV Formate" Value="3"></asp:ListItem>--%>
                </asp:RadioButtonList>
                 </td>
            </tr>
            <tr align="center" bgcolor="white">
                <td  colspan="6">
                <asp:Button  ID="btnShow"  OnClick="btnShow_Click" OnClientClick="Javascript: return DateCheck()" runat="server" Text="Show" Width="75px" />
                 </td>
            </tr>
                </table>
            </td>
        </tr>
        
    </table>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
