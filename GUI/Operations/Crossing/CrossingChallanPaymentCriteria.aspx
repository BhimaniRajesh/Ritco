<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="CrossingChallanPaymentCriteria.aspx.cs" Inherits="GUI_Operations_Crossing_CrossingChallanPaymentCriteria" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script type="text/javascript" language="javascript" src="../../images/commonJs.js"></script>
    <script type="text/javascript" language="javascript" src="../../images/CalendarPopup.js"></script>
    <script type="text/javascript" language="javascript">
     var cal = new CalendarPopup("testdiv1"); 
	 cal.setCssPrefix("TEST");
	 cal.showNavigationDropdowns();
	 
	 function CheckData()
	    {
	        if(document.getElementById("ctl00_MyCPH1_cboVendorType").value == "B")
                {
                    alert("Please Select Vendor Type....!!!")
                    return false;
                }
            if(document.getElementById("ctl00_MyCPH1_cboVendor").value == "0")
                {
                    alert("Please Select Vendor....!!!")
                    return false;
                }
	    }
    </script>

    <asp:Table ID="Table1" runat="server" CssClass="boxbg" Width="9in" CellSpacing="1"
        BorderWidth="0">
        <asp:TableRow CssClass="bgwhite">
            <asp:TableCell ColumnSpan="2" Font-Bold="true" HorizontalAlign="Center">
            Docket Selection Criteria
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow CssClass="bgwhite">
            <asp:TableCell Font-Bold="true">
           Select Vendor Type
            </asp:TableCell>
            <asp:TableCell Font-Bold="true">
                <asp:DropDownList ID="cboVendorType" runat="server" AutoPostBack="true" OnSelectedIndexChanged="cboVendorType_SelectedIndexChanged">
                    <asp:ListItem Text="Select" Value="B"></asp:ListItem>
                    <asp:ListItem Text="Crossing Vendor" Value="A"></asp:ListItem>
                </asp:DropDownList>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow CssClass="bgwhite">
            <asp:TableCell Font-Bold="true">
           Select Vendor
            </asp:TableCell>
            <asp:TableCell Font-Bold="true">
                <asp:DropDownList ID="cboVendor" runat="server">
                </asp:DropDownList>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow CssClass="bgwhite">
            <asp:TableCell Font-Bold="true">
            Crossing challan date
            </asp:TableCell>
            <asp:TableCell>
                <asp:Table ID="Table2" runat="server" CssClass="boxbg" CellSpacing="1" Width="100%">
                    <asp:TableRow CssClass="bgwhite">
                        <asp:TableCell>
                            <asp:RadioButtonList ID="radDate" runat="server" CssClass="blackfnt"
                                 ValidationGroup="VGDtFromTo"
                                Width="210px">
                                <asp:ListItem Selected="True" Text=" Date Range [dd/mm/yyyy]" Value="0"></asp:ListItem>
                                <asp:ListItem Text=" Last Week (Including Today)" Value="1"></asp:ListItem>
                                <asp:ListItem Text=" Today" Value="2"></asp:ListItem>
                                <asp:ListItem Text=" Till Date" Value="3"></asp:ListItem>
                            </asp:RadioButtonList>
                            </asp:TableCell>
                        <asp:TableCell VerticalAlign="Top">
                           <asp:Label ID="lblFrom" runat="server" CssClass="blackfnt" Text=" From: "></asp:Label>
                                    <asp:TextBox ID="txtDateFrom" MaxLength="10" CssClass="blackfnt" BorderStyle="Groove" runat="Server" Width="80"></asp:TextBox>
                                        <a href="#"  onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtDateFrom,'anchor1','dd/MM/yyyy'); return false;"  name="anchor1" id="anchor1" >
                                        <img src="../../images/calendar.jpg" alt="calendar.jpg" border="0" />
                                            
                                        </a> [dd/mm/yyyy]
                                   
                                    <asp:Label ID="lblTo" runat="server" CssClass="blackfnt" Text=" To: "></asp:Label>
                                    <asp:TextBox ID="txtDateTo" runat="Server" MaxLength="10" CssClass="blackfnt" BorderStyle="Groove" Width="80"></asp:TextBox>
                                        <a href="#"  onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtDateTo,'anchor11','dd/MM/yyyy'); return false;"  name="anchor11" id="anchor11" >
                                        <img src="../../images/calendar.jpg" alt="calendar.jpg" border="0" />
                                        
                                        </a> [dd/mm/yyyy]
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow CssClass="bgwhite">
            <asp:TableCell ColumnSpan="2" Font-Bold="true" HorizontalAlign="Center">
            OR
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow ID="trdockno" runat="server" CssClass="bgwhite">
            <asp:TableCell Font-Bold="true">
                     Enter crossing challan
            </asp:TableCell>
            <asp:TableCell ColumnSpan="3" HorizontalAlign="Left">
                <table>
                    <tr>
                        <td>
                            <asp:TextBox ID="txtcrossingchallan" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                Width="300px"></asp:TextBox></td>
                        <td>
                            (If Multiple Enter Seprate by Comma)
                        </td>
                    </tr>
                </table>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow CssClass="bgbluegrey">
            <asp:TableCell ColumnSpan="2" HorizontalAlign="Center">
                <asp:Button ID="btnsubmit" Text="Submit"
                    runat="server" CssClass="blackfnt" OnClientClick="javascript:return CheckData()" OnClick="btnsubmit_Click" />
            </asp:TableCell>
        </asp:TableRow>
    </asp:Table>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 99;">
    </div>
</asp:Content>
