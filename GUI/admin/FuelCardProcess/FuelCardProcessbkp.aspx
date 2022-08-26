<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="FuelCardProcess.aspx.cs" Inherits="GUI_admin_FuelCardProcess_FuelCardProcess" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <UserControl:UserMessage runat="server" ID="UserMessage" />
    <script src="../../images/commonJs.js" type="text/javascript"></script>
   

    <script language="javascript" type="text/javascript">
        var cal = new CalendarPopup("divDate");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
        var serviceUrl = '<%=ResolveClientUrl("~/RestService/MasterService.svc")%>';
       
        var CurrentUser = '<%= SessionUtilities.CurrentEmployeeID %>';
     
    </script>
 <script src="JS/FuelCardProcess.js?V=<%=System.DateTime.Now.Ticks %>" type="text/javascript"></script>

    <div style="width: 10in">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" style="height: 50px">
            <tr>
                <td>
                    <font class="blackfnt"><a href=""><b><u>Module </u></b></a>&gt; <a href="../../welcome.aspx">
                        <b><u>Administrator </u></b></a>&gt; <a href="../company_structure.aspx"><b><u>Fuel Card Process </u></b></a>&gt; <b><u>Fuel Card Process </u></b></font>
                    <td>
                        <a href="javascript:window.history.go(-1)" title="back">
                            <img src="../../images/back.gif" border="0" alt="" /></a>
                    </td>
            </tr>
        </table>
        <table border="0" width="100%" cellpadding="1" cellspacing="1" class="boxbg">
            <tr class="bgbluegrey">
                <td align="center" style="height: 21px">
                    <font class="blackfnt"><b>Fuel Card Process</b></font>
                </td>
            </tr>
        </table>
<hr />
        <br />
        <br />
            <table border="1" width="100%" runat="server" id="tblMain">
                <tr class="hrow">
                   
                    <td>
                        <font class="blackfnt"><b>System Date</b></font>
                    </td>
                    <td>
                        <font class="blackfnt"><b>Vehicle No.<font class="redfnt">*</font></b></font>
                    </td>
                    <td>
                        <font class="blackfnt"><b>Tripsheet No.<font class="redfnt">*</font></b></font>
                    </td>
                    <td>
                        <font class="blackfnt"><b>Tripsheet Date</b></font>
                    </td>
                    <td>
                        <font class="blackfnt"><b>Fuel Card no.</b></font>
                    </td>
                    <td>
                        <font class="blackfnt"><b>Fuel Type<font class="redfnt">*</font></b></font>
                    </td>
                    <td>
                        <font class="blackfnt"><b>City<font class="redfnt">*</font></b></font>
                    </td>
                    <td>
                        <font class="blackfnt"><b>Swapping Date<font class="redfnt">*</font></b></font>
                    </td>
                    <td>
                        <font class="blackfnt"><b>Transaction ID<font class="redfnt">*</font></b></font>
                    </td>
                    <td>
                        <font class="blackfnt"><b>QTY (Ltr)<font class="redfnt">*</font></b></font>
                    </td>
                    <td>
                        <font class="blackfnt"><b>Rate (Ltr)<font class="redfnt">*</font></b></font>
                    </td>
                    <td>
                        <font class="blackfnt"><b>Amount</b></font>
                    </td>
                    <td>
                        <font class="blackfnt"><b>Remarks<font class="redfnt">*</font></b></font>
                    </td>
                </tr>
                <tr>
                    <td align="left">
                        <%=System.DateTime.Now.ToString("dd/MM/yyyy") %>
                    </td>
                    <td align="left">
                       <asp:TextBox runat="server" ID="txtVehicleNo" ></asp:TextBox>
                        <asp:HiddenField ID="hdnVehicleNo" runat="server" />
                    </td>
                    <td align="left">
                        <asp:TextBox runat="server" ID="txtTripSheetNo" onblur="javascript: GetTripSheetDetail()" ></asp:TextBox>
                        <asp:HiddenField ID="hdnTripSheetNo" runat="server" />
                    </td>
                    <td align="left">
                         <asp:Label Text="" runat="server" ID="lblTripSheetDate" Width="150" />
                    </td>
                    <td align="left">
                        <asp:Label Text="" runat="server" ID="lblFuelCardNo" Width="100"/>
                    </td>
                      <td align="left">
                          <asp:DropDownList runat="server" ID="ddlFuelType">
                              <asp:ListItem Text="Diesel" Value="Diesel" Selected="True" />
                              <asp:ListItem Text="Add Blue" Value="AddBlue" />
                               <asp:ListItem Text="CNG" Value="CNG" />
                          </asp:DropDownList>
                      
                    </td>
                      <td align="left">
                        <asp:TextBox runat="server" ID="txtCity" ></asp:TextBox>
                           <asp:HiddenField ID="hdnCity" runat="server" />
                    </td>
                      <td align="left">
                         <asp:TextBox ID="txtSwappingDate" runat="Server" Width="100"></asp:TextBox>&nbsp;
                    <a href="#" onclick="cal.select(ctl00_MyCPH1_txtSwappingDate, 'CaltxtSwappingDate', 'dd/MM/yyyy'); return false;"
                        id="CaltxtSwappingDate">
                        <img src="../../images/calendar.jpg" border="0" alt="" />
                    </a>
                    </td>
                      <td align="left">
                        <asp:TextBox runat="server" ID="txtTransactionId"></asp:TextBox>
                    </td>
                      <td align="left">
                      <asp:TextBox runat="server" ID="txtQTY" Text="0.00" onkeypress="javascript:return validFloat(event,this.id);" onchange="javascript: CalculateAmount();"></asp:TextBox>
                    </td>
                      <td align="left">
                        <asp:TextBox runat="server" ID="txtRate" Text="0.00" onkeypress="javascript:return validFloat(event,this.id);" onchange="javascript: CalculateAmount();"></asp:TextBox>
                    </td>
                      <td align="left">
                        <asp:Label Text="" runat="server" ID="lblAmount" />
                    </td>
                    <td align="left">
                        <asp:TextBox runat="server" ID="txtRemarks" MaxLength="400" onpaste="return false"></asp:TextBox>
                    </td>
                </tr>
                
                <tr align="center" class="hrow">
                    <td colspan="13">


                        <input type="button" value="Submit" class="btn btn-primary" id="btnSubmit" onclick="javascript: SubmitClick();" />
                    </td>
                </tr>
            </table>
       
    </div>
    <div id="divDate" style="position: absolute; visibility: hidden; background-color: white; z-index: 99;">
    </div>

</asp:Content>

