<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ContractScanCopyView.aspx.cs"
    Inherits="GUI_admin_CustomerContractMaster_ContractScanCopyView" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script language="javascript" type="text/javascript">

        function topWindow(contractid, contractidFolder) {
            if (contractid != "") {
                var strWinFeature1 = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
                var strPopupURL1 = "../../../UploadedImages/" + contractid
                winNew = window.open(strPopupURL1, "_blank", strWinFeature1)
                return false;
            }
            else {
                alert("Image is not Uploaded...");
                return false;
            }
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Table runat="server" CssClass="boxbg" HorizontalAlign="left" CellSpacing="1"
            Width="100%" ID="Table1">
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell ColumnSpan="2">
                    <asp:GridView HorizontalAlign="Center" ID="grvFileName" runat="server" CellSpacing="1"
                        BorderWidth="0px" HeaderStyle-CssClass="hrow" AllowSorting="True" AllowPaging="True"
                        PagerStyle-HorizontalAlign="left" CssClass="ftbl" FooterStyle-CssClass="frow"
                        SelectedRowStyle-Font-Bold="true" RowStyle-HorizontalAlign="Center" RowStyle-CssClass="nrow"
                        AutoGenerateColumns="False" OnRowDataBound="grvFileName_OnRowDataBound" EmptyDataText="No Records Found..."
                        Visible="true" Width="90%">
                        <Columns>
                            <asp:TemplateField HeaderText="FileName">
                                <ItemTemplate>
                                    <asp:Label ID="lblFileName" CssClass="nfnt" Text=' <%# DataBinder.Eval( Container.DataItem,"Filename") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="UploadDate">
                                <ItemTemplate>
                                    <asp:Label ID="lblDateTime" CssClass="nfnt" Text=' <%# DataBinder.Eval( Container.DataItem,"UploadDate") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkviewFile" CssClass="nfnt" runat="server"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%-- <asp:TemplateField >
                    <ItemTemplate>
                <asp:LinkButton  ID="lnkDeleteFile" CommandName="Select" CommandArgument='<%#DataBinder.Eval(Container.DataItem,"Filename")%>'
  CssClass="nfnt" runat="server">
  </asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>--%>
                        </Columns>
                        <RowStyle CssClass="nrow" HorizontalAlign="Center" />
                        <FooterStyle CssClass="frow" />
                        <PagerStyle HorizontalAlign="Center" CssClass="hrow" />
                        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                        <SelectedRowStyle Font-Bold="True" />
                        <HeaderStyle CssClass="hrow" />
                    </asp:GridView>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
        <asp:HiddenField ID="hdnContractID" runat="server" />
    </div>
    </form>
</body>
</html>
