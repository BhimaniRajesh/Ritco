<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Query.aspx.cs" Inherits="GUI_UNI_NET_MIS_ExpenseRegister_Query" %>

<%@ Register TagName="HR" TagPrefix="Location" Src="~/GUI/Common_UserControls/LOC_HRCHY.ascx" %>
<%@ Register TagName="HR_To" TagPrefix="Location_To" Src="~/GUI/Common_UserControls/LOC_HRCHY_TO.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="JavaScript" src="./../../Images/CalendarPopup.js" type="text/javascript"></script>

    <script language="javascript" src="./../../images/commonJs.js" type="text/javascript"></script>

    <script language="JavaScript" type="text/javascript">
    
    var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
	
	 function OnSub_DATACHECK()
     {
     //alert("HIii")
        if(!DateCheck())
            return false;
      //  alert("HIii")
       /* if(!FinDateCheck())
            return false;     */        
     }
     
    function SelectPartyCode()
     {
        if(document.getElementById("ctl00_MyCPH1_documet_type_0").checked ==true)
        {
            document.getElementById('ctl00_MyCPH1_trMode').style.display = "block";
            document.getElementById('ctl00_MyCPH1_trRoute').style.display = "block";
        }
        else
        {
            document.getElementById('ctl00_MyCPH1_trMode').style.display = "none";
            document.getElementById('ctl00_MyCPH1_trRoute').style.display = "none";
        }
     }
	
	function cust(ID)
        {
         var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=600 ,height=400,status=no,left=60,top=50"
            var strPopupURL = "./../PopUp_Cust.aspx?ID="+ID
            
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
        
    </script>

    
    <br />
     <input type="hidden" id="hdnRptId" runat="server" /> <%-- added by Manisha 26/5/2014 --%>
  <div align="left">
        <table style="width: 8.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                        class="blklnkund"><strong>Reports </strong></font><font class="bluefnt"><strong>&gt;
                        </strong><strong>Expense Register</strong> </font>
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="./../../images/clear.gif" width="2" height="1"></td>
            </tr>
            <tr>
                <td align="right">
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img alt="Back" src="./../../images/back.gif" border="0" />
                    </a>
                </td>
            </tr>
            <tr>
                <td height="300" valign="top">
                    <table cellspacing="1" style="width: 8.5in" class="boxbg" align="left">
                        <tr class="bgbluegrey">
                            <td colspan="7" align="center" style="height: 21px">
                                <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Select Sales Criteria </asp:Label>
                            </td>
                        </tr>
                        <tr id="Tr1" visible="true" runat="server" style="background-color: white">
                            <td align="left">
                                <asp:Label ID="Label12" CssClass="blackfnt" Text="Select Document Type" runat="server"></asp:Label></td>
                            <td align="left" valign="top">
                                <asp:RadioButtonList ID="documet_type" runat="server" RepeatDirection="horizontal"
                                    CssClass="blackfnt" OnClick="Javascript:return SelectPartyCode()">
                                    <%--OnClick="Javascript:return SelectPartyCode()"--%>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr class="bgbluegrey">
                            <td align="center">
                                <font class="blackfnt"><b>From</b></font>
                            </td>
                            <td align="center">
                                <font class="blackfnt"><b>To</b></font>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left">
                                <Location_To:HR_To ID="Tolc" runat="server" />
                            </td>
                            <td align="left">
                                <Location:HR ID="Fromlc" runat="server" />
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left">
                                <font class="blackfnt">Select Date</font>
                            </td>
                            <td align="left" colspan="3">
                                <Date:DT ID="DT" runat="server" />
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td colspan="7">
                                <asp:Label ID="Label1" CssClass="blackfnt" Font-Bold="true" runat="server" Text=" OR "></asp:Label>
                            </td>
                        </tr>
                        <tr bgcolor="white">
                            <td colspan="7">
                                <asp:Label ID="Labesys" CssClass="blackfnt" runat="server" Text=" Document No(s). (System Generated No.) :� "></asp:Label>
                                <asp:TextBox runat="server" Text="" ID="txtDocumentNo" Width="250"> </asp:TextBox>
                                <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                            </td>
                        </tr>
                        <tr style="background-color: white" runat="server" id="trMode">
                            <td align="left" width="400">
                                <asp:Label ID="Label6" CssClass="blackfnt" Text="Select Mode" runat="server" Width="100%"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="DDLMode" runat="server">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr style="background-color: white" runat="server" id="trRoute">
                            <td align="left" width="400">
                                <asp:Label ID="Label6routr" CssClass="blackfnt" Text="Select Route" runat="server"
                                    Width="100%"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="DDLROute" runat="server">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left" width="400">
                                <asp:Label ID="Label2" CssClass="blackfnt" Text="Select Vendor Type" runat="server"
                                    Width="100%"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="DDLVendorType" runat="server">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <%--<tr style="background-color: white">
                            <td align="left" width="400">
                                <asp:Label ID="Labelvendthc" CssClass="blackfnt" Text="Select Vendor" runat="server"
                                    Width="100%"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="DDLVendor_thc" runat="server">
                                </asp:DropDownList>
                            </td>
                        </tr>--%>
                        <tr style="background-color: white">
                            <td align="left" width="400">
                                <asp:Label ID="Labelvendthc" CssClass="blackfnt" Text="Select Vendor" runat="server"
                                    Width="100%"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtVendor" Enabled="true" runat="server" Width="134"></asp:TextBox><input
                                                type="button" onclick="cust('V');" value="..." style="width: 18px; height: 21px"
                                                size="" /> 
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left" width="400">
                                <asp:Label ID="LabeSt" CssClass="blackfnt" Text="Select Staus" runat="server" Width="100%"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="DDLStatus_thc" runat="server">
                                    <asp:ListItem Value="All" Text="All"></asp:ListItem>
                                   <%-- <asp:ListItem Value="1" Text="Contract Entry Made"></asp:ListItem>--%>
                                    <asp:ListItem Value="2" Text="Advance Made"></asp:ListItem>
                                    <asp:ListItem Value="3" Text="Bill Entry Done"></asp:ListItem>
                                    <asp:ListItem Value="4" Text="Financial Close"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                </td>
            </tr>
            <tr align="center" bgcolor="white">
                <td colspan="7">
                    <asp:Button ID="btnShow" runat="server" Text="Show" Width="75px" BorderStyle="Groove"
                        OnClick="btnShow_Click" />
                </td>
            </tr>
        </table>
    </div>
     <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
    <div id="Div1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
