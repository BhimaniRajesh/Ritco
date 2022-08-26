<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="FixedExpenseAdd.aspx.cs" Inherits="GUI_admin_FixedExpense_FixedExpenseAdd" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <UserControl:UserMessage runat="server" ID="UserMessage" />
      <script type="text/javascript">
            var btnStep1 = '#<%= btnStep1.ClientID%>';
            var btnSumbmit = '#<%= btnSubmit.ClientID%>';
      </script>
   
    <script src="../../images/commonJs.js" type="text/javascript"></script>
    <script src="JS/FixedExpense.js?V5" type="text/javascript"></script>
    <div style="width: 6in">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" style="height: 50px">
            <tr>
                <td>
                    <font class="blackfnt"><a href=""><b><u>Module </u></b></a>&gt; <a href="../../welcome.aspx">
                        <b><u>Administrator </u></b></a>&gt; <a href="../company_structure.aspx"><b><u>Company
                            Structure </u></b></a>&gt; <b><u>Fixed Expense</u></b></font>
                </td>
                <td>
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img src="../../images/back.gif" border="0" alt="" /></a>
                </td>
            </tr>
        </table>
        <table border="0" width="100%" cellpadding="1" cellspacing="1" class="boxbg">
            <tr class="bgbluegrey">
                <td align="center" style="height: 21px">
                    <font class="blackfnt"><b>Fixed Expense</b></font>
                </td>
            </tr>
        </table>
        <table border="1" width="100%">
            <!--Row 1-->
            <tr bgcolor="#ffffff">
                <td align="left">
                    <font class="blackfnt">Select Option</font>
                </td>
                <td align="left" style="display: inline">
                    <asp:DropDownList runat="server" ID="ddlOption"></asp:DropDownList>
                </td>
            </tr>
            <tr class="hrow">
                <td align="center" colspan="2">
                    <asp:Button Text="Step-1" runat="server" Visible="true" class="btn btn-primary" OnClientClick="javascript: CheckOption();" OnClick="btnStep1_Click" ID="btnStep1" />
                </td>
            </tr>
        </table>
        <table border="1" width="100%" runat="server" id="tblMain">
            <tr class="hrow">
                <td>
                    <font class="blackfnt"><b>Selected Option</b></font>
                </td>
                <td colspan="2">
                    <font class="blackfnt"><b><asp:Label ID="lblOption" runat="server"></asp:Label></b></font>
                </td>
            </tr>
            <tr>
                <td>Tyre Exp.</td>
                <td>
                    <asp:TextBox runat="server" ID="txtTyreExp" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Text="0.00" Style="text-align: right"></asp:TextBox>
                </td>
                <td>Per KM
                </td>
            </tr>
            <tr>
                <td>AMC
                </td>
                <td>
                    <asp:TextBox runat="server" ID="txtAMC" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Text="0.00" Style="text-align: right"></asp:TextBox>
                </td>
                <td>Per KM
                </td>
            </tr>
            <tr>
                <td>Documents
                </td>
                <td>
                    <asp:TextBox runat="server" ID="txtDocument" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Text="0.00" Style="text-align: right"></asp:TextBox>
                </td>
                <td>30 Days
                </td>
            </tr>
            <tr>
                <td>Other I
                </td>
                <td>
                    <asp:TextBox runat="server" ID="txtOtherI" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Text="0.00" Style="text-align: right"></asp:TextBox>
                </td>
                <td>30 Days
                </td>
            </tr>
             <tr>
                <td>Other II
                </td>
                <td>
                    <asp:TextBox runat="server" ID="txtOtherII" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Text="0.00" Style="text-align: right"></asp:TextBox>
                </td>
                <td>30 Days
                </td>
            </tr>
                <tr>
                <td>Vehicle Attached
                </td>
                <td colspan="2">
                    <asp:TextBox runat="server" ID="txtVehicle" ReadOnly="false"></asp:TextBox>
                    <asp:Label ID="Label1" runat="server" BorderStyle="Groove" TabIndex="18" Text='<a href="javascript:nwOpen(1)">...</a>' Width="14px"></asp:Label>
                </td>
            </tr>
            <tr align="center" class="hrow">
                <td colspan="5">
                    <asp:Button Text="Submit" OnClick="btnSubmit_Click" runat="Server" OnClientClick="javascript: BtnSubmit();" class="btn btn-primary" id="btnSubmit"/>
                </td>
            </tr>
        </table>
    </div>
    <div id="divDate" style="position: absolute; visibility: hidden; background-color: white; z-index: 99;">
    </div>
</asp:Content>

