<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="GeneralMasterEdit.aspx.cs" Inherits="GUI_admin_GeneralMaster_GeneralMasterEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="javascript">

        function confirmDel() {

            if (confirm("You Sure You want to Delete this Record ?"))
                return true;
            else
                return false;
        }
    </script>

    <script type="text/javascript" language="javascript">

        function alterDisplay(operation, txtcodeid, lblcodeid, chkactiveid, hdnactiveid, hdnorgcodedescid, lblmodid, hdnid) {
            var txtcode = document.getElementById(txtcodeid);
            var lblcode = document.getElementById(lblcodeid);

            var chkactive = document.getElementById(chkactiveid);
            var hdnactive = document.getElementById(hdnactiveid);

            var hdnorg = document.getElementById(hdnorgcodedescid);
            
            var lblmod = document.getElementById(lblmodid);
            var hdnchange = document.getElementById(hdnid);

            if (operation == "0") {
                //debugger;
                if (txtcode.style.display == 'none') {
                    //debugger;
                    txtcode.style.display = "block";
                    lblcode.style.display = "none";
                    txtcode.focus();
                    txtcode.select();
                }
                else {
                    //debugger;
                    txtcode.style.display = "none";
                    lblcode.style.display = "block";
                    if (txtcode.value != hdnorg.value || hdnactive.value != String(chkactive.checked)) {
                        lblmod.innerText = "modified";
                        hdnchange.value = "1";
                    }
                    else {
                        lblmod.innerText = "";
                        hdnchange.value = "0";
                    }
                    lblcode.innerText = txtcode.value;
                }
            }
            else {
                //debugger;
                if (hdnactive.value != String(chkactive.checked) || txtcode.value != hdnorg.value) {
                    lblmod.innerText = "modified";
                    hdnchange.value = "1";
                }
                else {
                    lblmod.innerText = "";
                    hdnchange.value = "0";
                }
            }
        }
    </script>

    <br />
    <br />
    <div align="center" style="width: 9.5in;">
        <table border="0" cellpadding="3" cellspacing="1" class="stbl" width="90%">
            <tr class="hrow">
                <td colspan="4" align="center">
                    <asp:Label ID="lblmasterheader" runat="server"><strong>General Master</strong></asp:Label>
                </td>
            </tr>
        </table>
        <br />
        <asp:UpdatePanel ID="upd1" runat="server">
            <ContentTemplate>
                <table border="0" class="stbl" cellspacing="1" width="90%">
                    <tr class="nrow">
                        <td align="center">
                            <asp:GridView CssClass="ftbl" AutoGenerateColumns="false" RowStyle-CssClass="nrow" CellSpacing="1" HorizontalAlign="center" ID="grvgeneral" runat="server" BorderWidth="0" OnRowDataBound="grvgeneral_RowDataBound" HeaderStyle-CssClass="bgbluegrey">
                                <Columns>
                                    <asp:TemplateField HeaderText="Master No" HeaderStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lblcodeid" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"codeid") %>' CssClass="blackfnt"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Master Name" HeaderStyle-HorizontalAlign="Center">
                                        <ItemStyle HorizontalAlign="Left" />
                                        <ItemTemplate>
                                            <table>
                                                <tr class="nrow">
                                                    <td>
                                                        <asp:Label ID="lblcodedesc" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"codedesc") %>' CssClass="nftn" Width="250px"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtcodedesc" BackColor="Yellow" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"codedesc") %>' CssClass="ltxt" Width="250px"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:Label ForeColor="Green" ID="lblmodified" runat="server" CssClass="blackfnt"></asp:Label>
                                                    </td>
                                                    <td>
                                                    <asp:HiddenField ID="hdnchanged" runat="server" />
                                                    <asp:HiddenField ID="hdnoriginalcodedesc" runat="server" />
                                                    
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Active" HeaderStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkactive" runat="server" CssClass="blackfnt" />
                                            <asp:HiddenField ID="hdnactive" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr align="center" class="frow">
                        <td>
                            <asp:Button ID="btnsubmit" runat="server" CssClass="fbtn" Text="Submit" OnClick="submit_Click" />
                        </td>
                    </tr>
                </table>
                
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

</asp:Content>
