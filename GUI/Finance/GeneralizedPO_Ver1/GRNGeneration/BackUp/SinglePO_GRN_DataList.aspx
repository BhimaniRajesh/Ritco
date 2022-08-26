<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="SinglePO_GRN_DataList.aspx.cs" Inherits="GUI_Finance_GeneralizedPO_GRNGeneration_SinglePO_GRN_DataList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" src="../../../Images/commonJs.js" type="text/javascript"></script>

    <script language="javascript" src="../../Billing_Ver1/Billing.js" type="text/javascript"></script>

    <script type="text/javascript" language="javascript">
        function SelectAllcheckBox() {
            var dgGeneral = document.getElementById("ctl00_MyCPH1_GRNData");
            var rows, Prefix, chkRights, chkAll;
            chkAll = document.getElementById("ctl00_MyCPH1_GRNData_ctl01_chkSelectAll");
            if (dgGeneral != null) {
                rows = dgGeneral.rows.length;
                for (i = 1; i < rows - 1; i++) {
                    j = i + 1;
                    if (j < 10) {
                        Prefix = "ctl00_MyCPH1_GRNData_ctl0" + j;
                    }
                    else {
                        Prefix = "ctl00_MyCPH1_GRNData_ctl" + j;
                    }
                    chkSelect = document.getElementById(Prefix + "_chkb");
                    if (chkAll.checked)
                        chkSelect.checked = true;
                    else
                        chkSelect.checked = false;
                }
            }
            return true;
        }
    </script>

    <div>
        <table width="800" border="0" cellpadding="0" cellspacing="0">
            <tr bgcolor="white">
                <td style="height: 10px">
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Table ID="tblMain" runat="server" HorizontalAlign="center" CellSpacing="1" BorderWidth="0"
                        Width="100%" CssClass="ftbl">
                        <asp:TableRow CssClass="hrow" VerticalAlign="Middle" ID="trNonDeliveryReason" runat="server">
                            <asp:TableCell HorizontalAlign="center" ID="tdDocketHeader" runat="server" ColumnSpan="4"
                                Style="height: 20px;" Font-Bold="true"></asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle" ID="TableRow2" runat="server">
                            <asp:TableCell HorizontalAlign="left" Width="25%" CssClass="blackfnt" ID="tdPOType"
                                runat="server"></asp:TableCell>
                            <asp:TableCell HorizontalAlign="left" Width="25%" Wrap="true" ID="TableCell3"
                                runat="server">
                                <asp:Label ID="LblPOType" runat="server" CssClass="blackfnt"></asp:Label></asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle" ID="trDocketNo" runat="server">
                            <asp:TableCell HorizontalAlign="left" Width="25%" CssClass="blackfnt" ID="tdDocketNo"
                                runat="server"></asp:TableCell>
                            <asp:TableCell HorizontalAlign="left" Width="25%" Wrap="true" ID="tdlblRecordID"
                                runat="server">
                                <asp:Label ID="lblDocketNo" runat="server" CssClass="blackfnt"></asp:Label></asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle" ID="TableRow1" runat="server">
                            <asp:TableCell HorizontalAlign="left" Width="25%" CssClass="blackfnt" ID="tdManualDocketNo"
                                runat="server"></asp:TableCell>
                            <asp:TableCell HorizontalAlign="left" Width="25%" Wrap="true" ID="TableCell2"
                                runat="server">
                                <asp:Label ID="lblManualDocketNo" runat="server" CssClass="blackfnt"></asp:Label></asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle" ID="trFromDateToDate" runat="server">
                            <asp:TableCell HorizontalAlign="left" Width="25%" CssClass="blackfnt" ID="tdFromDateToDate"
                                runat="server">
                                                              Date Range</asp:TableCell>
                            <asp:TableCell HorizontalAlign="left" Width="25%" Wrap="true" ID="tdlblDateFromTo"
                                runat="server">
                                <asp:Label ID="lblFromDateToDate" runat="server" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle" ID="trNoOfDays" runat="server">
                            <asp:TableCell HorizontalAlign="left" Width="25%" CssClass="blackfnt" ID="tdNoOfDays"
                                runat="server">
                                                                    Party Code</asp:TableCell>
                            <asp:TableCell HorizontalAlign="left" Width="25%" Wrap="true" ID="tdlblNoOfDays"
                                runat="server">
                                <asp:Label ID="lblPartyCode" runat="server" CssClass="blackfnt"></asp:Label></asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </td>
            </tr>
            <tr bgcolor="white">
                <td style="height: 15px">
                </td>
            </tr>
            <tr bgcolor="white" id="Tr_Stn" runat="server">
                <td>
                    <asp:GridView ID="GV_Booking" runat="server" align="center" BorderWidth="1" CellPadding="2"
                        HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                        BackColor="white" AllowPaging="false" Width="800" AllowSorting="False" AutoGenerateColumns="false"
                        ShowFooter="false" EmptyDataText="No Records Found...">
                        <PagerStyle VerticalAlign="Bottom" />
                        <Columns>
                            <asp:BoundField DataField="pocode" ItemStyle-Wrap="true" HeaderText="PO Code" HeaderStyle-Font-Bold="true">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle Width="100" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Manual_PO_No" HeaderStyle-Font-Bold="true" HeaderText="Manual PO Code"
                                ItemStyle-BackColor="white" ItemStyle-Wrap="false">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" Width="150" />
                            </asp:BoundField>
                            <asp:BoundField DataField="podate" ItemStyle-Wrap="true" HeaderText="PO Date" HeaderStyle-Font-Bold="true">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle Width="100" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                            </asp:BoundField>
                            <asp:BoundField DataField="POTYPE" HeaderStyle-Font-Bold="true" HeaderText="PO Type"
                                ItemStyle-BackColor="white" ItemStyle-Wrap="false">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" Width="150" />
                            </asp:BoundField>                            
                            <asp:BoundField DataField="Vendorname" ItemStyle-Wrap="False" HeaderText="Vendor" HeaderStyle-Font-Bold="true">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle Width="400" Wrap="False" HorizontalAlign="Left" CssClass="blackfnt" />
                            </asp:BoundField>
                            <%--<asp:BoundField DataField="TotalQty" HeaderStyle-Font-Bold="true" HeaderText="Ordered Qty"
                                ItemStyle-BackColor="white" ItemStyle-Wrap="false">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" Width="150" />
                            </asp:BoundField>
                            <asp:BoundField DataField="RECEIVEDQTY" HeaderStyle-Font-Bold="true" HeaderText="Received Qty"
                                ItemStyle-BackColor="white" ItemStyle-Wrap="false">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" Width="150" />
                            </asp:BoundField>
                            <asp:BoundField DataField="BALANCEQTY" HeaderStyle-Font-Bold="true" HeaderText="Balance Qty"
                                ItemStyle-BackColor="white" ItemStyle-Wrap="false">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" Width="150" />
                            </asp:BoundField>--%>
                            <asp:BoundField DataField="PO_AMOUNT" HeaderStyle-Font-Bold="true" HeaderText="PO Amount"
                                ItemStyle-BackColor="white" ItemStyle-Wrap="false">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" Width="150" />
                            </asp:BoundField>
                            <asp:TemplateField ItemStyle-HorizontalAlign="left" HeaderText="Assign" HeaderStyle-Font-Bold="true">
                                <HeaderStyle HorizontalAlign="left" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <label  class="blackfnt"><asp:HyperLink Text='Assign' ID="Hyperlink3" Font-Underline="True" runat="server" 
                                    NavigateUrl='<%#"GRN_DetailList.aspx?VendorCode="+DataBinder.Eval(Container.DataItem, "Vendorname")+"&POList="+DataBinder.Eval(Container.DataItem, "pocode")+"&ManualPO="+DataBinder.Eval(Container.DataItem, "Manual_PO_No")+"&PODate="+DataBinder.Eval(Container.DataItem, "podate")+"&POType="+DataBinder.Eval(Container.DataItem, "POTYPE")+"&POAmount="+DataBinder.Eval(Container.DataItem, "PO_AMOUNT")%>'>
                                    </asp:HyperLink></label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
            <%--<tr>
                <td height="25px">
                </td>
            </tr>--%>
            <%--<tr>
                <td width="100%" style="border: solid 1px" align="center" class="bgbluegrey">
                    <table width="800" border="0" cellpadding="0" cellspacing="0" class="boxbg">
                        <tr>
                            <td class="bgbluegrey">
                                <asp:Button ID="btnSubmit" runat="server" Text="Submit" Width="75px" CssClass="fbtn"
                                    OnClick="btnSubmit_Click" OnClientClick="javascript:return CheckForCheckBox();" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>--%>
        </table>
    </div>

    <%--<script language="javascript" type="text/javascript">
        function CheckForCheckBox() 
        {
            var TargetBaseControl = document.getElementById('<%= this.GV_Booking.ClientID %>');
            var TargetChildControl = "ChkItem";
            var count = 0;
            //Get all the control of the type INPUT in the base control.
            var Inputs = TargetBaseControl.getElementsByTagName("input");
            //Checked/Unchecked all the checkBoxes in side the GridView.
            for (var n = 0; n < Inputs.length; ++n) {
                if (Inputs[n].checked == true)
                    count += 1;
            }
            if (count == 0) {
                alert("Select Atleast One Record");
                return false;
            }
            //Reset Counter
            return true;
        }

    </script>--%>

</asp:Content>
