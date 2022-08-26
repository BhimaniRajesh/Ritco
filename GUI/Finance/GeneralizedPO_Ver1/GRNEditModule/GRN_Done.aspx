<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="GRN_Done.aspx.cs" Inherits="GUI_Finance_GeneralizedPO_GRNGeneration_GRN_Done" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" src="../dropdowncontent.js"></script>

    <script language="javascript" type="text/javascript">
        //    function nwOpenViewWindow(url) {
        //        window.open(url,'myWindow','height=300,width=950,resizable=yes,scrollbars=yes,left=25,top=100');
        //    }
        //    function nwOpenPrintWindow(url) {
        //        window.open(url,'myWindow','height=300,width=950,resizable=yes,scrollbars=yes,left=25,top=100');
        //    }
        function ViewPrint(arg1, arg2) {
            window.open("../ViewPrint/GRNView.aspx?GRNNO=" + arg1 + "," + arg2, "es", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
        }
        function ViewPrintGRN(arg1, arg2) {
            window.open("../ViewPrint/GRNDetailsView.aspx?GRNNO=" + arg1 + "," + arg2, "es", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
        }
    
    </script>

    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="True" runat="server">Voucher Result</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
    <br />
    <br />
    <table border="0" width="100%">
        <tr>
            <td width="10%">
            </td>
            <td width="90%" align="left">
                <table border="0" class="boxbg" cellpadding="1" cellspacing="1" width="650">
                    <tr class="bgbluegrey">
                        <td align="center" colspan="3">
                            <asp:Label ID="lblHeader" runat="server" Font-Bold="true" Text="Following document has been successfully Updated:"
                                CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: White">
                        <td align="center">
                            <asp:Label ID="lblDocType" runat="server" Text="Goods Recipt Note" Font-Bold="True"
                                CssClass="blackfnt"></asp:Label>
                        </td>
                        <td align="center">
                            <asp:Label ID="lblDocName" runat="server" Font-Bold="True" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    <tr class="bgbluegrey">
                        <td align="left" colspan="3">
                            <asp:Label ID="lblNextStep" runat="server" Text="Your Next Step" Font-Bold="true"
                                CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: White">
                        <td align="left" colspan="3" style="height: 21px">
                            <a href="GRNCriteria.aspx"><font class="blackfnt">Edit More GRN</font> </a>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>
