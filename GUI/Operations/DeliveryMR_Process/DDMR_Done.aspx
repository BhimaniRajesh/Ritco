<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="DDMR_Done.aspx.cs" Inherits="GUI_Finance_GeneralizedPO_GRNGeneration_GRN_Done" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" src="../dropdowncontent.js"></script>

    <script language="javascript" type="text/javascript">
        function ViewPrint(arg1) {
            window.open("DDMRProcess_View.aspx?DDMRNo=" + arg1 , "es", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=700,height=500,status=no,left=60,top=125");
        }
    
    </script>

    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="True" runat="server">DDMR Process Result</asp:Label>
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
                        <td align="center" colspan="4">
                            <asp:Label ID="lblHeader" runat="server" Font-Bold="true" Text="Following document has been successfully Generated:"
                                CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: White">
                        <td align="center">
                            <asp:Label ID="lblDocType" runat="server" Text="Document" Font-Bold="True"
                                CssClass="blackfnt"></asp:Label>
                        </td>
                        <td align="center">
                            <asp:Label ID="Label1" runat="server" Font-Bold="True" Text="Number" CssClass="blackfnt"></asp:Label>
                        </td>
                        <td align="center">
                            <asp:Label ID="lblDocName" runat="server" Font-Bold="True" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: White">
                        <td align="center">
                            <asp:Label ID="Lbl_GRN" runat="server" Text="DDMR Process" Font-Bold="True"
                                CssClass="blackfnt"></asp:Label>
                        </td>
                        <td align="center">
                            <asp:Label ID="Lbl_DDMRNo" runat="server" Text="DDMR Process No" Font-Bold="True"
                                CssClass="blackfnt"></asp:Label>
                        </td>
                        <td align="center">
                            <font class="blklnkund"><a href="Javascript:ViewPrint('<%=Request.QueryString.Get("DDMRSNO")%>')">
                                <font class="blklnkund">View</font></a> | <a href="Javascript:ViewPrint('<%=Request.QueryString.Get("DDMRSNO")%>')">
                                    <font class="blklnkund">Print </font></a></font>
                        </td>
                    </tr>
                    <tr class="bgbluegrey">
                        <td align="left" colspan="4">
                            <asp:Label ID="lblNextStep" runat="server" Text="Your Next Step" Font-Bold="true"
                                CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: White">
                        <td align="left" colspan="4" style="height: 21px">
                            <a href="DDMRProcessCriteria.aspx"><font class="blackfnt">Prepare New DDMR Process</font> </a>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>
