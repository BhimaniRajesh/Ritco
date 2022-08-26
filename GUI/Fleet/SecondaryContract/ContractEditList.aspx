<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="ContractEditList.aspx.cs" Inherits="GUI_admin_CustomerContract" %>
<%@ Register Src="~/GUI/Common_UserControls/ProgressBar.ascx" TagName="ProgressBar"
    TagPrefix="pgr" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">

        //        function openEdit(choice) {

        //            var winOpts = "scrollbars=yes,resizable=yes,target=_self,width=" + 500 + ",height=" + 400 + "";
        //            window.open(choice, '', winOpts);
        //            return false;
        //        }
        //        function openScanUpload(custcode, contractid) {
        //            window.open("ContractScanCopyUpload.aspx?contractID=" + contractid + "&CustCode=" + custcode, null, "menubar=no,toolbar=no,location=no,resizable=no,scrollbars=no,width=980,height=160,status=no,left=20,top=150");
        //            return false;
        //        }

        function cancelClick() {
          
        }
    </script>

    <br />
         
    <asp:Panel runat="server" Width="10in" HorizontalAlign="Center">
        <asp:Table ID="Table1" runat="server" HorizontalAlign="Center" Width="100%">
            <asp:TableRow CssClass="nrow">
                <asp:TableCell HorizontalAlign="Left" Width="180px">
                    <asp:Label ID="lblcstnmlbl" runat="server" CssClass="nfnt"></asp:Label>
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
            <asp:LinkButton ID="lnkaddnew" runat="server" CssClass="nfnt" Font-Bold="true" Text="Add New Contract"
                OnClick="lnkaddnew_Click"></asp:LinkButton>
        </asp:Panel>
        <%--GRID VIEW OF DATA--%>
          <asp:UpdatePanel runat="server" ID="updone">
        <ContentTemplate>
     
        <asp:GridView HorizontalAlign="center" ID="grvcontractlist" runat="server" CellSpacing="1"
            BorderWidth="0" HeaderStyle-CssClass="hrow" AllowSorting="true" AllowPaging="true"
            PageSize="10" PagerStyle-HorizontalAlign="left" CssClass="ftbl" FooterStyle-CssClass="frow"
            SelectedRowStyle-Font-Bold="true" RowStyle-HorizontalAlign="Center" RowStyle-CssClass="nrow"
            AutoGenerateColumns="false" OnRowDataBound="grvcontractlist_RowDataBound" EmptyDataText="No Records Found..."
            OnPageIndexChanging="pgChange" Width="90%">
            <Columns>
                <asp:TemplateField HeaderText="Sr.No.">
                    <ItemTemplate>
                        <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="ContractID">
                    <ItemTemplate>
                        <%# DataBinder.Eval(Container.DataItem, "Contract_Code")%>
                        <asp:HiddenField ID="hdncontractid" Value='<%# DataBinder.Eval( Container.DataItem,"Contract_Code") %>'
                            runat="server" />
                        <asp:HiddenField ID="hdnstatus" Value='<%# DataBinder.Eval( Container.DataItem,"Status") %>'
                            runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Start Date">
                    <ItemTemplate>
                        <%# DataBinder.Eval(Container.DataItem, "Contract_From_Dt")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="End Date">
                    <ItemTemplate>
                        <%# DataBinder.Eval(Container.DataItem, "Contract_To_Dt")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Contract Type">
                    <ItemTemplate>
                        <%# DataBinder.Eval(Container.DataItem, "Contract_Based_On")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkview" CssClass="nfnt" runat="server">View</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
               <%-- <asp:TemplateField HeaderText="Status">
                    <ItemTemplate>
                        <asp:Label ID="lblstatus" CssClass="nfnt" Text=' <%# DataBinder.Eval( Container.DataItem,"Status") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>--%>
                <asp:TemplateField HeaderText="Edit">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkedit" CssClass="nfnt" runat="server" OnClick="lnkcontractedit_Click">Edit</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Action">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkdeactivate" CssClass="nfnt" runat="server" Text=' <%# DataBinder.Eval( Container.DataItem,"Status") %>' OnClick="lnkcontractdeactivate_Click"></asp:LinkButton>
                        <ajaxToolkit:ConfirmButtonExtender ID="ConfirmButtonExtender2" runat="server" TargetControlID="lnkdeactivate"
                            OnClientCancel="cancelClick" DisplayModalPopupID="ModalPopupExtender1" />
                        <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender1" runat="server" TargetControlID="lnkdeactivate"
                            PopupControlID="PNL" OkControlID="ButtonOk" CancelControlID="ButtonCancel" BackgroundCssClass="modalBackground" />
                        <asp:Panel ID="PNL" runat="server" Style="display: none; width: 200px; background-color: White;
                            border-width: 2px; border-color: Black; border-style: solid; padding: 20px;">
                            Are you sure you want to change status?
                            <br />
                            <br />
                            <div style="text-align: right;">
                                <asp:Button ID="ButtonOk" runat="server" Text="OK" />
                                <asp:Button ID="ButtonCancel" runat="server" Text="Cancel" />
                            </div>
                        </asp:Panel>
                        <asp:Label ID="Label1" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <%--      <asp:TemplateField HeaderText="">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkdelete" CssClass="redfnt" runat="server">Delete</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>--%>
            </Columns>
            <PagerStyle HorizontalAlign="Center" CssClass="hrow" />
            <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
        </asp:GridView>
        
    
        </ContentTemplate>
    </asp:UpdatePanel>
    <pgr:ProgressBar ID="pgrone" runat="server" />
    
        <asp:Table ID="tblgrid" runat="server" CellSpacing="1" CssClass="ftbl" Style="width: 90%;
            display: none;">
            <asp:TableRow CssClass="hrow">
                <asp:TableCell Font-Bold="true">No Contract Found</asp:TableCell>
            </asp:TableRow>
            <asp:TableRow BackColor="white">
                <asp:TableCell ColumnSpan="8" HorizontalAlign="Center" Font-Bold="true" CssClass="redfnt">No Records Found......</asp:TableCell>
            </asp:TableRow>
        </asp:Table>
        <asp:HiddenField ID="hdncustcode" runat="server" />
    </asp:Panel>
    
</asp:Content>
