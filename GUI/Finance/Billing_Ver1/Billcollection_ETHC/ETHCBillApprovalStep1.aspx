<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="ETHCBillApprovalStep1.aspx.cs" Inherits="GUI_Finance_Billing_Ver1_Billcollection_ETHC_ETHCBillApprovalStep1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="javascript">
        $(document).ready(function () {
            $("[id*='RdHCLApproval']").click(function () {
                //set name for all to name of clicked 
                $("[id*='RdHCLApproval']").not(this).attr("checked", false);
            });
        });
    </script>
    <UserControl:UserMessage runat="server" ID="UserMessage" />
    <table class="stbl" cellspacing="1" cellpadding="3" style="width: 50%" id="tblCriteria" runat="server">
        <tr class="hrow">
            <td colspan="2" align="center">
                <b>External THC Balance Pending For Approval Step 1</b>
            </td>
        </tr>
    </table>
    <br />
    
    <asp:Repeater ID="RptApproval" runat="server">
        <HeaderTemplate>
            <table id="Dochead" border="0" class="boxbg" cellpadding="1" cellspacing="1" width="50%">
                <thead>
                    <tr class="hrow">
                        <th><b>Select</b></th>
                        <th><b>Sr No.</b></th>
                        <th><b>Collection Document No.</b></th>
                        <th><b>Generation Date</b></th>
                    </tr>
                </thead>
        </HeaderTemplate>
        <ItemTemplate>
            <tbody>
                <tr class="nrow">
                    <td>
                        <asp:RadioButton runat="server" ID="RdHCLApproval" />
                    </td>
                    <td>
                        <asp:Label ID="lblSrno" runat="server" Text='<%# Eval("Srno") %>'></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblMRNo" runat="server" Text='<%# Eval("MRSNO") %>'></asp:Label>
                        <asp:HiddenField runat="server" ID="hdnMRNo" Value='<%# Eval("MRSNO") %>' />
                    </td>
                    <td>
                        <asp:Label ID="lblMRDate" runat="server" Text='<%# Eval("MRSDT") %>'></asp:Label>
                    </td>
                </tr>

            </tbody>
        </ItemTemplate>
        <FooterTemplate>
            <tr class="nrow">
                <td align="center" colspan="5">
                    <asp:Button ID="btnNext" runat="server" Text="Next" OnClick="btnNext_Click" />
                </td>
            </tr>
            </table>
        </FooterTemplate>
    </asp:Repeater>

</asp:Content>

