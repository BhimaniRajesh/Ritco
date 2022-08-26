<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="false" CodeFile="StateMasterView.aspx.cs"
    Inherits="GUI_admin_StateMaster_StateMasterView" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Untitled Page</title>
    <link href="../../../GUI/images/style.css" rel="stylesheet" type="text/css" />

    <script language="javascript" type="text/javascript">
        function printPage() {
            var hdnflagprint = document.getElementById("hdnflagprint");

            if (hdnflagprint.value == "Y")
                window.print();

            return false;
        }

        function popupPrint() {
            var hdnCode = document.getElementById("hdnCode");
            var winOpts = "scrollbars=yes,resizable=yes,width=" + 500 + ",height=" + 400 + "";
            window.open("stateMasterView.aspx?state=" + hdnCode.value + "&print=Y", "", winOpts);
            return false;
        }
    </script>

</head>
<body onload="javascript:return printPage()">
    <form id="form1" runat="server">
    <br />
    <asp:Panel runat="server" Width="10in">
        <table width="100%">
            <tr>
                <td>
                    <table width="75%" align="left">
                        <tr>
                            <td align="right">
                                <asp:LinkButton ID="lnkBtnPrint" runat="server" CssClass="blackfnt" Text="Print |"
                                    OnClientClick="javascript:return popupPrint();"></asp:LinkButton>
                                <asp:LinkButton ID="lnkBtnDownloadXLS" runat="server" CssClass="blackfnt" OnClick="lnkBtnDownloadXLS_Click">Download XLS</asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Table runat="server" CssClass='<%=boxbg %>' HorizontalAlign="left" CellSpacing="1"
                        Width="75%" ID="tblMain">
                        <asp:TableRow CssClass='<%=bgbluegrey %>' ID="trStateMaster" runat="server">
                            <asp:TableCell Font-Bold="true" CssClass="blackfnt" HorizontalAlign="center" ColumnSpan="4"
                                ID="tdStateMaster" runat="server">
                            State Master</asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="bgwhite">
                            <asp:TableCell ID="tdStateCode" runat="server" Wrap="false" CssClass="blackfnt">
                            State Code
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="left"  ID="lbltdStateCode" Wrap="false"
                                runat="server">
                                <asp:Label ID="lblStateCode" runat="server" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell ID="tdStateName"  runat="server" Wrap="false" CssClass="blackfnt">
                            State Name 
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="left" ID="lbltdStateName" Wrap="false"
                                runat="server">
                                <asp:Label ID="lblState" runat="server" Font-Bold="true" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        
                        <asp:TableRow CssClass="bgwhite">
                         <asp:TableCell ID="tdStaxFlag" runat="server" Wrap="false" CssClass="blackfnt">
                            Service Tax Exempted
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="left" ID="lbltdStaxFlag" Wrap="false"
                                runat="server">
                                <asp:Label ID="lblStax" runat="server" Font-Bold="false" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell ID="tdActiveFlag" runat="server" Wrap="false" CssClass="blackfnt">
                            Active Flag
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="left"  ID="lbltdActiveFlag" Wrap="false"
                                runat="server">
                                <asp:Label ID="lblActiveFlag" runat="server" Font-Bold="false" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                          <asp:TableRow CssClass="bgwhite">
                            <asp:TableCell Width="25%" ID="tdFreightRate" runat="server" CssClass="blackfnt">
                                Freight Rate
                            </asp:TableCell>
                            <asp:TableCell Width="25%" ID="lbltdFreightRate" runat="server">
                                <asp:Label ID="lblFreightRate" runat="server" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell Width="25%" ID="tdUpdateBy" runat="server" CssClass="blackfnt">
                                Last Update By  
                            </asp:TableCell>
                            <asp:TableCell Width="25%" ID="lbltdUpdateBy" runat="server" ColumnSpan="0">
                                <asp:Label ID="lblUpdateby" runat="server" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="bgwhite">
                            <asp:TableCell Width="25%" ID="tdFreightRateType" runat="server" CssClass="blackfnt">
                                Freight Rate Type
                            </asp:TableCell>
                            <asp:TableCell Width="25%" ID="lbltdFreightRateType" runat="server">
                                <asp:Label ID="lblFreightRateType" runat="server" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell Width="25%" ID="tdUpdateOnDate" runat="server" CssClass="blackfnt">
                                Last Update Date
                            </asp:TableCell>
                            <asp:TableCell Width="25%" ID="lbltdUpdateOnDate" runat="server" ColumnSpan="0">
                                <asp:Label ID="lblUpdateDate" runat="server" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow HorizontalAlign="center" CssClass="bgwhite">
                            <asp:TableCell HorizontalAlign="center" ColumnSpan="4" ID="tdgvState" runat="server">
                                <asp:GridView ID="gvState" runat="server" BorderWidth="0" CellSpacing="1" HeaderStyle-CssClass='<%=bgbluegrey %>'
                                    PagerStyle-HorizontalAlign="left" AllowSorting="False" AutoGenerateColumns="false"
                                    OnRowDataBound="gvState_RowDataBound" EmptyDataText="No Records Found..." Width="100%">
                                    <PagerStyle VerticalAlign="Bottom" />
                                    <Columns>
                                        <asp:TemplateField HeaderStyle-Font-Bold="true" HeaderText="Document Name">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="True" Width="50%" CssClass="blackfnt" />
                                            <ItemStyle CssClass="bgwhite" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblDocument" runat="server" Text='<%# DataBinder.Eval( Container.DataItem,"stform") %>'
                                                    CssClass="blackfnt"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        
                                        
                                        <asp:TemplateField HeaderStyle-Font-Bold="true" HeaderText="Inbound / Outbound">
                                            <HeaderStyle HorizontalAlign="Center" Width="50%"  Wrap="True" CssClass="blackfnt" />
                                            <ItemStyle CssClass="bgwhite" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblInOutbound" runat="server" Text='<%# DataBinder.Eval( Container.DataItem,"inoutbound") %>'
                                                    CssClass="blackfnt"></asp:Label>
                                                <asp:HiddenField ID="hdnbound" runat="server" Value='<%# DataBinder.Eval( Container.DataItem,"inoutbound") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <%-- <asp:TemplateField HeaderText="Active Flag">
                                    <HeaderStyle HorizontalAlign="Center" Font-Bold="true" CssClass="blackfnt" />
                                    <ItemStyle HorizontalAlign="Center" CssClass="bgwhite" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblActiveFlag" runat="server" Text='<%# DataBinder.Eval( Container.DataItem,"activeflag") %>'
                                            CssClass="blackfnt"></asp:Label>
                                        <asp:HiddenField ID="hdnactiveflag" runat="server" Value='<%# DataBinder.Eval( Container.DataItem,"activeflag") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>    --%>
                                    </Columns>
                                </asp:GridView>
                            </asp:TableCell>
                        </asp:TableRow>
                      
                    </asp:Table>
                </td>
            </tr>
        </table>
        <asp:HiddenField ID="hdnflagprint" runat="server" />
        <asp:HiddenField ID="hdnCode" runat="server" />
    </asp:Panel>
    </form>
</body>
</html>
