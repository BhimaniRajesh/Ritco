<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="GSTProductServiceMapingMaster.aspx.cs" Inherits="GUI_admin_GSTMaster_GSTProductServiceMapingMaster" %>

<%@ Register Src="~/GUI/Common_UserControls/UserMessage.ascx" TagPrefix="uc1" TagName="UserMessage" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script type="text/javascript">


        $(document).ready(function () {

        });
       

        function onBtnSubmit_Click() {
            try {

                //var lstServiceType = $("select[id$=ddlServiceType]");
                //for (var i = 0; i < lstServiceType.length; i++) {
                //    for (var j = 0; j < lstServiceType.length; j++) {
                //        if (i != j && $(lstServiceType[i]).val() == $(lstServiceType[j]).val()) {
                //            alert("Can not select multiple Service type  !!");
                //            $(lstServiceType[i]).focus();
                //            return false;
                //        }
                //    }
                //}

                if (confirm("Are you sure to save  Product Service Mapping Details?")) {
                    return true;
                }
                else {
                    return false;
                }
            } catch (e) {
                alert(e.message);
                return false;
            }
        }
    </script>
    <table cellspacing="1" style="width: 100%">
        <tbody>
            <tr style="background-color: white">
                <td align="left">
                    <span id="ctl00_MyCPH1_lblPageHead" class="blackfnt" style="font-weight: bold;">Product- Service Type Mapping</span>
                    <hr align="center" size="1" color="#8ba0e5">
                </td>
            </tr>
        </tbody>
    </table>
    <br />
    <%--<asp:HiddenField ID="hdnSACGSTDetails" runat="server" />--%>
    <asp:Panel ID="pnl_Mapping" runat="server" Width="500px">
        <table id="tbl_Product_Master" class="boxbg" style="width: 100%">
            <thead>
                <tr class="bgbluegrey">
                    <th width="50" align="center">Sr No</th>
                    <th width="150" align="center">Product Type</th>
                    <th width="150" align="center">Service Type</th>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="rp_ProductServiceMapping" runat="server" OnItemDataBound="rp_ProductServiceMapping_ItemDataBound">
                    <ItemTemplate>
                        <tr bgcolor="#FFFFFF">
                            <td align="center">
                                <asp:Label ID="lblSrNo" runat="server" Text='<%# Eval("SrNo") %>'></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblProductType" runat="server" Text='<%# Eval("ProductTypeText") %>'></asp:Label>
                                <asp:HiddenField ID="hdnProductType" runat="server" Value='<%# Eval("ProductType") %>' />
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlServiceType" runat="server" DataTextField="CodeDesc" DataValueField="CodeId" style="width:250px"></asp:DropDownList>
                                <asp:HiddenField ID="hdnSeriviceType" runat="server" Value='<%# Eval("ServiceType") %>' />
                                <%--onchange="onSACCategorySelection_Change(this)"--%>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                    </FooterTemplate>
                </asp:Repeater>
                <tr class="bgbluegrey">
                    <td colspan="6" align="center">
                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" OnClientClick="return onBtnSubmit_Click();" />
                    </td>
                </tr>
            </tbody>
        </table>
    </asp:Panel>
    <table id="tblDetailSaved" runat="server" class="boxbg" cellpadding="3" cellspacing="1" visible="false" width="500">
        <thead>
            <tr class="bgbluegrey">
                <th>
                    <asp:Label ID="lblMsg" runat="server" Text="" Font-Bold="true"></asp:Label>
                </th>
            </tr>
        </thead>
        <tbody>
            <tr class="bgwhite">
                <td>
                    <a href="GSTProductServiceMapingMaster.aspx">Click here to update Product Service Mapping details.</a>
                </td>
            </tr>
        </tbody>
    </table>
    <uc1:UserMessage runat="server" ID="msgBox" />
</asp:Content>

