<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="StandardExpense_FixedRouteSelectEdit.aspx.cs" Inherits="GUI_Fleet_Operations_Issue_New_TripSheet_Validation_StandardExpense_FixedRouteSelectEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <%--<script language="javascript" type="text/javascript" src="VendorPayment.js"></script>
    <script language="javascript" type="text/javascript" src="../../../GUI/images/CommonJS.js"></script>
    <script language="javascript" type="text/javascript" src="../../../admin/FuelSlipMaster/FuelSlipMaster_JS.js"></script>
    <script language="javascript" type="text/javascript" src="FuelRateMaster.js"></script>--%>


    <script language="javascript" type="text/javascript">
        function CheckEmpty()
        { 
            var txtRouteNo = document.getElementById("ctl00_MyCPH1_txtRouteNo");
            var ddlRouteName = document.getElementById("ctl00_MyCPH1_ddlRouteName");
            var txtVehicleNo = document.getElementById("ctl00_MyCPH1_txtVehicleNo");
          
            //alert(ddlRouteName.value);
            //alert(txtRouteNo.value);
            //alert(txtVehicleNo.value);

            if (ddlRouteName.value == "All" && txtVehicleNo.value == "" && txtRouteNo.value == "")
            {
                alert("Please enter atleast one option");
                return false;
            }
        }
    </script>

    <asp:UpdateProgress ID="UpdateProgress1" runat="server">
        <ProgressTemplate>
            <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px; -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                <tr>
                    <td align="right">
                        <img src="../../images/loading.gif" alt="" /></td>
                    <td><font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font></td>
                </tr>
            </table>
            <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px; background-color: #FFFFFF; width: 100%; height: 100%; filter: Alpha(Opacity=50); opacity: .50; -moz-opacity: .50;"
                runat="server">
                <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%; left: 50%;"
                    ID="Panel2" runat="server">
                </asp:Panel>
            </asp:Panel>
        </ProgressTemplate>
    </asp:UpdateProgress>

    <div align="left" style="width: 75%">
        <asp:UpdatePanel ID="UP1" runat="Server">
            <ContentTemplate>
                <table cellspacing="1" border="0" style="width: 100%">
                    <tr align="left">
                        <td colspan="3">
                            <table cellspacing="1" style="width: 90%" class="boxbg" border="0">
                                <tr class="bgbluegrey">
                                    <td colspan="3" align="center" style="height: 21px">
                                        <asp:Label ID="Label5" CssClass="blackfnt" Font-Bold="true" runat="server">
                                               Edit For Standard Expense For Fixed Route
                                        </asp:Label>
                                    </td>
                                </tr>
                                <tr style="background-color: white">
                                    <td align="center" style="width: 30%">
                                        <asp:Label Font-Bold="true" Text="Route No" runat="server" />
                                    </td>
                                    <td align="left" style="width: 50%" colspan="2">
                                        <asp:UpdatePanel ID="UpdatePanel1" RenderMode="Inline" UpdateMode="Always" runat="server">
                                            <ContentTemplate>
                                                <asp:TextBox CssClass="input" Width="300px" ID="txtRouteNo" runat="Server" BorderStyle="Groove"></asp:TextBox>
                                                <ajaxToolkit:AutoCompleteExtender ID="Ext1a" runat="server"
                                                    Enabled="True"
                                                    CompletionListItemCssClass="autocomplete_listItem"
                                                    CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" MinimumPrefixLength="1"
                                                    ServiceMethod="GetRouteNo" ServicePath="~/GUI/Fleet/AtlasAutoComplete.asmx" TargetControlID="txtRouteNo">
                                                </ajaxToolkit:AutoCompleteExtender>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                                <tr style="background-color: white">
                                    <td colspan="3" align="center" style="width: 30%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label Text="OR" Font-Bold="true" runat="server" />
                                    </td>
                                </tr>
                                <tr style="background-color: white">
                                    <td align="center" style="width: 30%">
                                        <asp:Label Font-Bold="true" Text="Route Name" runat="server" />
                                    </td>
                                    <td align="left" style="width: 50%" colspan="2">
                                        <asp:UpdatePanel ID="UpdatePanel2" RenderMode="Inline" UpdateMode="Always" runat="server">
                                            <ContentTemplate>
                                                <asp:DropDownList ID="ddlRouteName" AutoPostBack="True" runat="server" Width="300px" CssClass="input">
                                                </asp:DropDownList>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                                <tr style="background-color: white">
                                    <td colspan="3" align="center" style="width: 30%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label Text="OR" Font-Bold="true" runat="server" />
                                    </td>
                                </tr>
                                <tr style="background-color: white">
                                    <td align="center" style="width: 30%">
                                        <asp:Label Font-Bold="true" Text="Vehicle No." runat="server" />
                                    </td>
                                    <td align="left" style="width: 50%" colspan="2">
                                        <asp:UpdatePanel ID="UpdatePanel3" RenderMode="Inline" UpdateMode="Always" runat="server">
                                            <ContentTemplate>
                                                <asp:TextBox CssClass="input" Width="300px" ID="txtVehicleNo" runat="Server" BorderStyle="Groove"></asp:TextBox>
                                                <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server"
                                                    Enabled="True"
                                                    CompletionListItemCssClass="autocomplete_listItem"
                                                    CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" MinimumPrefixLength="1"
                                                    ServiceMethod="GetAllVehicle" ServicePath="~/GUI/Fleet/AtlasAutoComplete.asmx" TargetControlID="txtVehicleNo">
                                                </ajaxToolkit:AutoCompleteExtender>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                                <tr style="background-color: white">
                                    <td colspan="4" align="center">
                                        <asp:Button ID="btnSubmit" ValidationGroup="grpQuery" runat="server" Text="Submit" OnClientClick="javascript: return CheckEmpty()" OnClick="btnSubmit_Click" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues"></asp:SqlDataSource>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
