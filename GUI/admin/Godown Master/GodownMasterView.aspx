<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="false" CodeFile="GodownMasterView.aspx.cs"
    Inherits="GUI_admin_GodownMaster_GodownMasterView"  %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Untitled Page</title>
    <link href="../../../GUI/images/style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript">
     function printPage() 
     {
        var hdnflagprint = document.getElementById("hdnflagprint");   
         
        if(hdnflagprint.value == "Y")      
          window.print();
        
        return false;
     }
     
     function popupPrint()
     {
            var hdnCode = document.getElementById("hdnCode");
            var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";      
            window.open("GodownMasterView.aspx?print=Y&locCode="+hdnCode.value,"", winOpts);         
            return false;
     }
    </script>
</head>
<body onload="javascript:return printPage()">
    <form id="form1" runat="server">
        <br />
        <asp:Panel runat="server" Width="10in">
            <table width="75%" align="center">
                <tr>
                    <td align="right">
                        <br />
                        <br />
                        <br />
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <asp:LinkButton ID="lnkBtnPrint" runat="server" CssClass="blackfnt" Text="Print |"
                            OnClientClick="javascript:return popupPrint();" Visible="false" ></asp:LinkButton>
                        <asp:LinkButton ID="lnkBtnDownloadXLS" runat="server" Visible="false" CssClass="blackfnt" OnClick="lnkBtnDownloadXLS_Click">Download XLS</asp:LinkButton>
                    </td>
                </tr>
            </table>
            <asp:Table runat="server" CssClass='<%=boxbg %>' HorizontalAlign="Center" CellSpacing="1"
                Width="75%" ID="tblMain">
                <asp:TableRow CssClass='<%=bgbluegrey %>' ID="trStateMaster" runat="server">
                    <asp:TableCell Font-Bold="true" CssClass="blackfnt" HorizontalAlign="center" ColumnSpan="4"
                        ID="tdStateMaster" runat="server">
                            <b>WAREHOUSE MASTER</b></asp:TableCell>
                </asp:TableRow>            
                <asp:TableRow HorizontalAlign="center" CssClass="bgwhite">
                    <asp:TableCell HorizontalAlign="center" ColumnSpan="4" ID="tdgvState" runat="server">
                        <asp:GridView ID="gvGodown" BorderWidth="0" CellSpacing="1" runat="server" AutoGenerateColumns="false"
                            Width="100%" CssClass="boxbg" HeaderStyle-CssClass="bgbluegrey" FooterStyle-CssClass="bgwhite"
                            PagerSettings-Mode="NumericFirstLast" EmptyDataText="No record found..."  PageSize="10" SelectedIndex="1">
                            <Columns>
                                <asp:TemplateField HeaderText="Sr.No." ItemStyle-Width="25px" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackfnt" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblsrnocomplainlist" CssClass="blackfnt" Text="<%# Container.DataItemIndex+1 %>"
                                            runat="server"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="100px" HeaderText="Location" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackfnt" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblLocCode" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"spdbrcd") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="100px" HeaderText="Godown Name" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackfnt" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblgodownName" runat="server" Text='<%# DataBinder.Eval( Container.DataItem,"godown_Name") %>'
                                            CssClass="blackfnt"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="100px" HeaderText="Godown Description" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackfnt" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblgodownDesc" runat="server" Text='<%# DataBinder.Eval( Container.DataItem,"godown_Desc") %>'
                                            CssClass="blackfnt"></asp:Label>                                        
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="100px" HeaderText="Active Flag" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackfnt" />
                                    <ItemStyle HorizontalAlign="Center" />   
                                    <ItemTemplate>
                                        <asp:Label ID="lblActiveFlag" runat="server" Text='<%# DataBinder.Eval( Container.DataItem,"Activeflag") %>'
                                            CssClass="blackfnt"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="100px" HeaderText="Area in Square Feet" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackfnt" />
                                    <ItemStyle HorizontalAlign="Center" />   
                                    <ItemTemplate>
                                        <asp:Label ID="lblArea" runat="server" Text='<%# DataBinder.Eval( Container.DataItem,"Area") %>'
                                            CssClass="blackfnt"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="100px" HeaderText="Address" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackfnt" />
                                    <ItemStyle HorizontalAlign="Center" />   
                                    <ItemTemplate>
                                        <asp:Label ID="lblAddress" runat="server" Text='<%# DataBinder.Eval( Container.DataItem,"GodownAddress") %>'
                                            CssClass="blackfnt"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="100px" HeaderText="ValidityDate" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackfnt" />
                                    <ItemStyle HorizontalAlign="Center" />   
                                    <ItemTemplate>
                                        <asp:Label ID="lblValidityDate" runat="server" Text='<%# DataBinder.Eval( Container.DataItem,"ValidityDate") %>'
                                            CssClass="blackfnt"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </asp:TableCell>
                </asp:TableRow>               
            </asp:Table>
            <asp:HiddenField ID="hdnflagprint" runat="server" />
            <asp:HiddenField ID="hdnCode" runat="server" />
        </asp:Panel>
    </form>
</body>
</html>
