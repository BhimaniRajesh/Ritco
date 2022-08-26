<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Split_DCR.aspx.cs" Inherits="GUI_admin_PrintDcr" %>

<%@ Register Src="~/GUI/Common_UserControls/ProgressBar.ascx" TagName="ProgressBar"
    TagPrefix="uc1" %>
<%@ Register Src="../../Common_UserControls/MyMessageBox.ascx" TagName="MyMessageBox"
    TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="JavaScript" type="text/javascript">

        function chkTotalLeaf(obj) {
            if (obj.value == "") {
                alert("Total Leaf cann't br empty..!");
            }
            else if (obj.value <= 0) {
                alert("Total Leaf must be greater then 0");
            }
        }

        function MakeUpper(objRef) {
            // This gets the value for the textbox that was focussed
            var curValue = objRef.value;
            //Assign the suggested value to the box
            objRef.value = curValue.toUpperCase();
        }

        function OnSubmit() {
            var ddlDocType = document.getElementById('<%=ddlDocType.ClientID %>');
            var txtBookCode = document.getElementById('<%=txtBookCode.ClientID %>');
            var txtSeriesFrom = document.getElementById('<%=txtSeriesFrom.ClientID %>');
            var txtTotalLeaf = document.getElementById('<%=txtTotalLeaf.ClientID %>');
            var ddlAlloteTo = document.getElementById('<%=ddlAlloteTo.ClientID %>');
            var ddlLocations = document.getElementById('<%=ddlLocations.ClientID %>');
            var ddlAllotCat = document.getElementById('<%=ddlAllotCat.ClientID %>');

            if (ddlDocType.value == "") {
                alert("Please Select Document Type.");
                ddlDocType.focus();
                return false;
            }
            //            else if (txtBookCode.value == "") {
            //                alert("Please Enter Book Code.");
            //                txtBookCode.focus();
            //                return false;
            //            }
            else if (txtSeriesFrom.value == "") {
                alert("Please Enter Series From.");
                txtSeriesFrom.focus();
                return false;
            }
            else if (txtTotalLeaf.value == "" || txtTotalLeaf.value == "0") {
                alert("Total Leaf can not be 0 or blank.");
                txtTotalLeaf.focus();
                return false;
            }
            else if (ddlLocations.value == "") {
                alert("Please Select Allote To Location.");
                ddlLocations.focus();
                return false;
            }
            else if (ddlAllotCat.value == "E" || ddlAllotCat.value == "B") {
                if (ddlAlloteTo.value == "") {
                    alert("Please Select Allote To.");
                    ddlAlloteTo.focus();
                    return false;
                }
            }
            else
                return true;
        }

        function OnBookCodeChange() {
            var txtBookCode = document.getElementById('<%=txtBookCode.ClientID %>');
            var ddlDocType = document.getElementById('<%=ddlDocType.ClientID %>');
            if (ddlDocType.value == "") {
                alert("Please Select Document Type.");
                txtBookCode.value = "";
                ddlDocType.focus();
            }
            else if (txtBookCode.value != "") {
                MakeUpper(txtBookCode);
                WebXBCSerialService.IsBookCodeExist(txtBookCode.value, ddlDocType.value, OnBookCodeChangeSuccess);
            }
        }
        function OnBookCodeChangeSuccess(result) {
            var txtBookCode = document.getElementById('<%=txtBookCode.ClientID %>');
            var strRes = result.split('|');

            if (strRes[0] == "1") {
                alert(strRes[1]);
                txtBookCode.value = "";
                txtBookCode.focus();
            }
            else if (strRes[0] == "2") {
                alert(strRes[1]);
                txtBookCode.value = "";
                txtBookCode.focus();
            }
            return result;
        }

        function onDocumentChange() {
            var txtBookCode = document.getElementById('<%=txtBookCode.ClientID %>');
            var txtSeriesFrom = document.getElementById('<%=txtSeriesFrom.ClientID %>');
            var txtTotalLeaf = document.getElementById('<%=txtTotalLeaf.ClientID %>');
            var ddlAlloteTo = document.getElementById('<%=ddlAlloteTo.ClientID %>');
            txtBookCode.value = "";
            txtSeriesFrom.value = "";
            txtTotalLeaf.value = "";
            ddlAlloteTo.value = "";
        }
    </script>

    <div class="blackfnt">
        <table cellspacing="1" style="width: 100%">
            <tr style="background-color: white">
                <td align="left">
                    <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Split Series</asp:Label>
                    <hr align="center" size="1" color="#8ba0e5" />
                </td>
            </tr>
        </table>
        <br />
        <uc1:ProgressBar ID="ProgressBar1" runat="server" />
        <br />
        <asp:UpdatePanel ID="updtPNL" runat="server" RenderMode="Inline">
            <ContentTemplate>
                <table cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td>
                            <table class="boxbg" cellpadding="1" cellspacing="1" border="0">
                                <tr class="bgbluegrey">
                                    <td align="center" colspan="8">
                                        <b>Split Document Series</b>
                                    </td>
                                </tr>
                                <tr class="bgwhite" height="2px">
                                    <td align="center" colspan="8">
                                        <span style="font-size: xx-small;">&nbsp;</span>
                                    </td>
                                </tr>
                                <tr class="bgbluegrey" align="center">
                                    <td>
                                        <asp:Label ID="Label3" runat="server" Text="Document Type" Font-Bold="true"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label6" runat="server" Text="Book Code" Font-Bold="true"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label1" runat="server" Text="Series From" Font-Bold="true"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label2" runat="server" Text="Total Leaf" Font-Bold="true"></asp:Label>
                                    </td>
                                    <td id="tdBTH" runat="server" visible="false">
                                        <asp:Label ID="Label4" runat="server" Text="Business Type" Font-Bold="true"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label7" runat="server" Text="Allote To Location" Font-Bold="true"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label8" runat="server" Text="Allot Category" Font-Bold="true"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label5" runat="server" Text="Allote To" Font-Bold="true"></asp:Label>
                                    </td>
                                </tr>
                                <tr class="bgwhite" align="center">
                                    <td>
                                        <asp:DropDownList ID="ddlDocType" runat="server" onchange="onDocumentChange();">
                                            <asp:ListItem Text="--Select--" Value=""></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblBookCode" runat="server" Text=""></asp:Label>
                                        <asp:HiddenField ID="hidSuffix" runat="server" />
                                        <asp:TextBox ID="txtBookCode" runat="server" Visible="false" onchange="javascript:OnBookCodeChange()"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtSeriesFrom" runat="server" onchange="javascript:MakeUpper(this)"
                                            OnTextChanged="txtSeriesFrom_onTextChanged" AutoPostBack="true"></asp:TextBox>
                                    </td>
                                    <td>
                                        <%--onchange="javascript:chkTotalLeaf(this)"--%>
                                        <asp:TextBox ID="txtTotalLeaf" runat="server" Style="text-align: right" Enabled="false"
                                            Width="80"></asp:TextBox>
                                    </td>
                                    <td id="tdBTD" runat="server" visible="false">
                                        <asp:DropDownList ID="ddlBusType" runat="server">
                                            <asp:ListItem Text="--SELECT--" Value="0"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlLocations" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlLocations_SelectedIndexChanged">
                                            <asp:ListItem Text="--SELECT--" Value=""></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlAllotCat" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlAllotCat_SelectedIndexChanged">
                                            <asp:ListItem Text="--SELECT--" Value=""></asp:ListItem>
                                            <asp:ListItem Text="Employee" Value="E">
                                            </asp:ListItem>
                                            <asp:ListItem Text="BA" Value="B"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlAlloteTo" runat="server">
                                            <asp:ListItem Text="--SELECT--" Value=""></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr class="bgwhite">
                                    <td colspan="8" align="center">
                                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClientClick="JavaScript:return OnSubmit()"
                                            OnClick="btnSubmit_Click" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <uc1:MyMessageBox ID="msgBox" runat="server" ShowCloseButton="true" />
                        </td>
                    </tr>
                </table>
                <%--<asp:Label ID="lblErrors" runat="server" CssClass="redfnt"></asp:Label>--%></ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
