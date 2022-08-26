<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="ContractEditList.aspx.cs" Inherits="GUI_admin_CustomerContract" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">
 function popupmenu2(choice)
 { 
  var winOpts="scrollbars=yes,resizable=yes,target=_self,width="+500+",height="+400+"";
  window.open(choice);
 }
 function openEdit(choice)
 { 
 
  var winOpts="scrollbars=yes,resizable=yes,target=_self,width="+500+",height="+400+"";
  window.open(choice,'',winOpts);
 return false;
 }
  function openScanUpload(custcode,contractid)
   {   
      window.open("ContractScanCopyUpload.aspx?contractID="+contractid+"&CustCode=" + custcode,null,"menubar=no,toolbar=no,location=no,resizable=no,scrollbars=no,width=980,height=200,status=no,left=20,top=150");   
      return false;
   }
    function openViewScanUpload(custcode, contractid) {
            window.open("ContractScanCopyView.aspx?contractID=" + contractid + "&CustCode=" + custcode, null, "menubar=no,toolbar=no,location=no,resizable=no,scrollbars=no,width=980,height=360,status=no,left=20,top=150");
            return false;
        }
    </script>

    <br />
    <%--<u><font class="blackfnt"><b>Docket Entry</b> >> <font class="bluefnt"><b>Edit List</b></font></font></u>--%>
    <br />
    <asp:Panel runat="server" Width="10in" HorizontalAlign="Center">
        <asp:Table ID="Table1" runat="server" HorizontalAlign="Center" Width="100%" CssClass="blackfnt">
            <asp:TableRow BackColor="White">
                <asp:TableCell HorizontalAlign="Left" Width="180px">
				       &nbsp;Customer Code & Name
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
                    :
                    <asp:Label ID="lblcustcodename" runat="server" onmouseover="this.style.cursor='pointer'"
                        CssClass="blackfnt" Font-Bold="true"></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
        <br />
        <br />
        <asp:Panel ID="divone" HorizontalAlign="Left" runat="server" Width="90%">
            <asp:LinkButton ID="lnkaddnew" runat="server" CssClass="blackfnt" Font-Bold="true"
                Text="Add New Contract" OnClick="lnkaddnew_Click"></asp:LinkButton>
        </asp:Panel>
        <%--GRID VIEW OF DATA--%>
        <asp:GridView HorizontalAlign="center" ID="grvcontractlist" runat="server" CellSpacing="1"
            BorderWidth="0" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true" AllowPaging="true"
            PageSize="10" PagerStyle-HorizontalAlign="left" CssClass="boxbg" FooterStyle-CssClass="boxbg"
            SelectedRowStyle-Font-Bold="true" AutoGenerateColumns="false" RowStyle-CssClass="bgwhite"
            OnRowDataBound="grvcontractlist_RowDataBound" EmptyDataText="No Records Found..."
            OnPageIndexChanging="pgChange" Width="90%">
            <Columns>
                <asp:TemplateField HeaderText="Sr.No.">
                    <HeaderStyle HorizontalAlign="Center" Font-Bold="true" Wrap="False" CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="ContractID">
                    <ItemTemplate>
                        <%# DataBinder.Eval( Container.DataItem,"contractid") %>
                        <asp:HiddenField ID="hdncontractid" Value='<%# DataBinder.Eval( Container.DataItem,"contractid") %>'
                            runat="server" />
                        <asp:HiddenField ID="hdnstatus" Value='<%# DataBinder.Eval( Container.DataItem,"activeflag") %>'
                            runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Start Date">
                    <HeaderStyle HorizontalAlign="Center" Font-Bold="true" Wrap="False" CssClass="blackfnt" />
                    <ItemTemplate>
                        <%# DataBinder.Eval(Container.DataItem, "startdate")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="End Date">
                    <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                    <ItemTemplate>
                        <%# DataBinder.Eval( Container.DataItem,"enddate") %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Contract Type">
                    <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                    <ItemTemplate>
                        <%# DataBinder.Eval( Container.DataItem,"contracttype") %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="">
                    <HeaderStyle HorizontalAlign="Center" Font-Bold="true" Wrap="False" CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkview" CssClass="blackfnt" runat="server" OnClick="lnkdockview_Click">View</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Status">
                    <HeaderStyle HorizontalAlign="Center" Font-Bold="true" Wrap="False" CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:Label ID="lblstatus" CssClass="blackfnt" Text=' <%# DataBinder.Eval( Container.DataItem,"status") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Edit">
                    <HeaderStyle HorizontalAlign="Center" Font-Bold="true" Wrap="False" CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkedit" CssClass="blackfnt" runat="server" OnClick="lnkcontractedit_Click">Edit</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Action">
                    <HeaderStyle HorizontalAlign="Center" Font-Bold="true" Wrap="False" CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkdeactivate" CssClass="blackfnt" runat="server" OnClick="lnkcontractdeactivate_Click">DeActivate</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Phy Scan Copy">
                    <HeaderStyle HorizontalAlign="Center" Font-Bold="true" Wrap="False" CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkscancopy" CssClass="blackfnt" runat="server">Upload</asp:LinkButton> | 
                       <asp:LinkButton ID="lnkviewscancopy" CssClass="blackfnt" runat="server">View </asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="">
                    <HeaderStyle HorizontalAlign="Center" Font-Bold="true" Wrap="False" CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkdelete" CssClass="redfnt" runat="server">Delete</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
            <HeaderStyle CssClass="bgbluegrey" />
            <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
            <FooterStyle CssClass="boxbg" />
        </asp:GridView>
        <asp:Table ID="tblgrid" runat="server" CellSpacing="1" CssClass="boxbg"
            Style="width: 90%; display: none;">
            <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell Font-Bold="true" CssClass="blackfnt">No Contract Found</asp:TableCell>
            </asp:TableRow>
            <asp:TableRow BackColor="white">
                <asp:TableCell ColumnSpan="8" HorizontalAlign="Center" Font-Bold="true" CssClass="redfnt">No Records Found......</asp:TableCell>
            </asp:TableRow>
        </asp:Table>
        <asp:UpdateProgress ID="uppMain" runat="server">
            <ProgressTemplate>
                <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px;
                    -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                    <tr>
                        <td align="right">
                            <img src="../../images/loading.gif" alt="" />
                        </td>
                        <td>
                            <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font>
                        </td>
                    </tr>
                </table>
                <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px;
                    background-color: #FFFFFF; width: 100%; height: 100%; filter: Alpha(Opacity=50);
                    opacity: .50; -moz-opacity: .50;" runat="server">
                    <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                        left: 50%;" ID="Panel2" runat="server">
                    </asp:Panel>
                </asp:Panel>
            </ProgressTemplate>
        </asp:UpdateProgress>
        <asp:HiddenField ID="hdncustcode" runat="server" />
    </asp:Panel>
</asp:Content>
