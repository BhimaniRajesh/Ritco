<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="start.aspx.cs" Inherits="Finance_Billing_Billsubmission_start" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <div>
        <table style="width: 10in" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    <br />
                    <table border="0" style="width: 6in" bgcolor="#808080" cellpadding="2" cellspacing="1"
                        class="boxbg">
                        <tr class="bgbluegrey">
                            <td colspan="3">
                                Select Process
                            </td>
                        </tr>
                        <tr bgcolor="#FFFFFF">
                            <td>
                                <asp:RadioButton ID="RD_Process_PO" runat="server" Text="GRN From Purchase order" 
                                GroupName="RD_Prcess" CssClass="blackfnt" Checked="true" />
                            </td>
                            <td>
                                <asp:RadioButton ID="RD_Process_STN" runat="server" Text="GRN From Stock Transfer Note" 
                                GroupName="RD_Prcess" CssClass="blackfnt" />
                            </td>
                            <td>
                                <asp:RadioButton ID="RD_Process_SKU" runat="server" Text="GRN From Stock Update" 
                                GroupName="RD_Prcess" CssClass="blackfnt"/>
                            </td>
                        </tr>
                        <tr class="bgbluegrey" align="center">
                            <td colspan="3">
                                <asp:Button ID="ButSubmit" runat="server" Text="Submit" OnClick="ButSubmit_Click"
                                    CssClass="BtnClass" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>