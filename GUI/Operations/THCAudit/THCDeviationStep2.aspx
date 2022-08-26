<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="THCDeviationStep2.aspx.cs" Inherits="GUI_Operations_THCAudit_THCDeviationStep2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="JavaScript" type="text/javascript">

        $(document).ready(function () {
            
            $("[id*=tblTHCDetail] tr").each(function () {
            //    $(this).find("input[id$=ChkSelect]").prop('checked', 'checked')

            });
        });

        function ValidateTHCSelect() {
            var returnval = true;
            $("[id*=tblTHCDetail] tr").each(function () {

                try {
                    if ($(this).find("input[id$=ChkSelect]").is(":checked") == true && $(this).find("input[id$=txtRemark]").val() == "") {
                        returnval = false;
                        throw "Please enter final remark for selected THC!";
                    }
                } catch (e) {
                    alert(e)
                    returnval = false;
                }
            });
            return returnval;
        }
    </script>

    <div align="left">
        <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                        class="blklnkund"><strong>Oprations</strong></font><font class="bluefnt"><strong>
                            &gt; </strong><strong>THC Deviation Module</strong> </font>
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="../../images/clear.gif" alt="" width="2" height="1" /></td>
            </tr>
            <tr>
                <td align="right">
                    <div align="center">
                        <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                            <ProgressTemplate>
                                <div id="progressArea">
                                    <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="redfnt" Font-Bold="true"></asp:Label>
                                    <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                                </div>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </div>

                </td>
            </tr>
            <tr>
                <td valign="top">
                    <table cellspacing="1" style="width: 9.5in" class="boxbg" align="left">
                        <tr class="bgbluegrey">
                            <td colspan="2">
                                <font class="blackfnt"></font>
                            </td>
                            <td colspan="2">
                                <font class="blackfnt"><b>You selected</b></font>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left" colspan="2">
                                <font class="blackfnt">Selected Date</font>
                            </td>
                            <td align="left" colspan="2">
                                <asp:Label Text="" Font-Bold="true" ID="lblSelectedDate" runat="server" />
                            </td>
                        </tr>
                        <tr style="background-color: white;">
                            <td align="left" colspan="2">
                                <font class="blackfnt">THC No.</font>
                            </td>
                            <td align="left" colspan="2">
                                <asp:Label runat="server" Font-Bold="true" Text="" ID="lblTHCno"> </asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: white;">
                            <td align="left" colspan="2">
                                <asp:Label class="blackfnt" ID="lblRecord" runat="server"></asp:Label>
                            </td>
                            <td align="left" colspan="2">
                              
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <br />
                </td>
            </tr>

            <tr>
                <td valign="top" >
                    <asp:Repeater runat="server" ID="rptThcDetail">
                        <HeaderTemplate>
                            <table width="100%" class="boxbg" border="0"
                                cellpadding="3" cellspacing="1" id="tblTHCDetail">
                                <tr class="bgbluegrey">
                                    <th>Select
                                    </th>
                                    <th>Branch Name
                                    </th>
                                    <th>THC No
                                    </th>
                                    <th>Manual THC No
                                    </th>
                                    <th>THC Date
                                    </th>
                                    <th>VehicleNo
                                    </th>
                                    <th>From
                                    </th>
                                    <th>To
                                    </th>
                                    <th>Customer Name
                                    </th>
                                    <th>PAN No
                                    </th>
                                    <th>Contract Amount
                                    </th>
                                    <th>Advance Amount
                                    </th>
                                    <th>Other
                                    </th>
                                    <th>Balance Amount
                                    </th>
                                    <th>Balance Payable At
                                    </th>
                                    <th>Total Charged Weight
                                    </th>
                                    <th>Total Actual Weight
                                    </th>
                                    <th>Rate
                                    </th>
                                    <th>Total Freight
                                    </th>
                                    <th>Dep Date
                                    </th>
                                    <th>No Of Package
                                    </th>
                                    <th>Deviation Remark
                                    </th>
                                    <th>Final Remark
                                    </th>
                                    <th>Audit User Name”
                                    </th>
                                    <th>Deviation User Name
                                    </th>
                                </tr>
                        </HeaderTemplate>
                        <ItemTemplate>

                            <tr style="background-color: white">
                                <td>
                                    <asp:CheckBox  Value="select" ID="ChkSelect" runat="server" />
                                </td>

                                <td>

                                    <%# DataBinder.Eval(Container.DataItem, "BranchName") %>
                                </td>
                                <td>
                                    <asp:HiddenField ID="hdnTHCNo" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"THCNo") %>' />
                                    <%# DataBinder.Eval(Container.DataItem,"THCNo") %>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "ManualTHCNo") %>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "THCDate") %>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "VehicleNo") %>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "fromcity") %>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "tocity") %>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "CustomerName") %>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "PANNo") %>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "ContractAmount") %>
                                </td>
                                <td>
									<%# DataBinder.Eval(Container.DataItem, "AdvanceAmount") %>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "OtherAdvance") %>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "BalanceAmount") %>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "BalancePayableAt") %>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "TotalChargedWeight") %>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "TotalActualWeight") %>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "Rate", "{0:0.00}") %>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "TotalFreight") %>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "DepDate") %>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "NoOfPackage") %>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "PendingRemark") %>
                                </td>
                                <td>
                                    <asp:TextBox runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "FinalRemark") %>' ID="txtRemark" />
                                </td>
                                <td>
                                <%# SessionUtilities.CurrentEmployeeID %>
                                </td>
                                <td>
                                <%# SessionUtilities.CurrentEmployeeID %>
                                </td>
                            </tr>
                        </ItemTemplate>

                        <FooterTemplate>
                            </Table>
                        </FooterTemplate>
                    </asp:Repeater>
                </td>
            </tr>
            <tr>
                <td>
                    <br />
                </td>
            </tr>
            <tr bgcolor="white" runat="server" id="TRsubmit" visible="false">
                <td colspan="3" align="center">
                    <asp:Button ID="btnSubmit" OnClick="btnSubmit_Click" OnClientClick="javascript: return ValidateTHCSelect();" runat="server" Text="Clear" Width="100px" />
                    Or
                                <asp:Button ID="btnKeepPending" OnClick="btnKeepPending_Click" OnClientClick="javascript: return ValidateTHCSelect();" runat="server" Text="Keep Pending" Width="100px" />
                </td>

            </tr>
        </table>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
