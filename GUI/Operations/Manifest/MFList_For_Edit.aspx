<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="MFList_For_Edit.aspx.cs" Inherits="GUI_Operations_Manifest_MFList_For_Edit"
    Title="Untitled Page" %>

<%@ Register Src="../../Common_UserControls/RPT_Date.ascx" TagName="RPT_Date" TagPrefix="uc" %>
<%@ Register Src="../../Common_UserControls/ProgressBar.ascx" TagName="ProgressBar"
    TagPrefix="uc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script src="../../images/commonJs.js" language="javascript" type="text/javascript"></script>

    <script src="../../Js/AssignValue.js" language="javascript" type="text/javascript"></script>

    <script src="../../images/CalendarPopup.js" language="javascript" type="text/javascript"></script>

    <script type="text/javascript" language="JavaScript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
    </script>

    <script type="text/javascript" language="JavaScript">
        function locTest(txtid, testtype) {
            var hdnajaxstate = document.getElementById("ctl00_MyCPH1_hdnajaxstate");
            hdnajaxstate.value = "1";

            //var hdnclient=document.getElementById("ctl00_MyCPH1_hdnclient");
            var txt = document.getElementById(txtid);
            if (txt.value == "") {
                hdnajaxstate.value = "0";
                return false;
            }

            txt.value = txt.value.toUpperCase();
            var strpg = "";
            var findobj = false;
            findobj = GetXMLHttpObject();
            if (findobj) {
                strpg = "../AjaxResponse.aspx?mode=check&code1=" + testtype + "&code2=" + txt.value + "&sid=" + Math.random() + "&sid=" + Math.random();

                findobj.open("GET", strpg);
                findobj.onreadystatechange = function() {
                    if ((findobj.readyState == 4) && (findobj.status == 200)) {
                        var res = findobj.responseText.split("|");
                        if (res[0] == "false") {
                            if (testtype == "citytest")
                                alert("City doesn't Exists...");
                            else if (testtype == "loctest")
                                alert("Please enter valid Location code...");
                            else if (testtype == "zonetest")
                                alert("Region doesn't Exists...");
                            else if (testtype == "emptest")
                                alert("Employee doesn't Exists...");

                            txt.value = "";
                            txt.focus();
                            hdnajaxstate.value = "0";
                            return false;
                        }
                        else if (res[0] == "true") {
                            hdnajaxstate.value = "0";
                        }
                    }
                }
                findobj.send(null);
            }

            return true;
        }

        function openPopupLoc() {
            window.open("popup_locations.aspx", null, "height=300,width=400,left=300,top=200,status=no,resizable=yes,scrollbars=yes,toolbar=no,location=no,menubar=no");
        }
    </script>

    <div class="blackfnt">
        <uc:ProgressBar ID="ProgressBar1" runat="server" />
        <asp:HiddenField ID="hdnajaxstate" runat="server" Value="0" />
        <table border="0" cellpadding="3" cellspacing="1" class="boxbg" width="800">
            <tr class="bgbluegrey">
                <td colspan="2" align="center">
                    <b>MF Selection Criterias</b>
                </td>
            </tr>
            <tr class="bgwhite">
                <td valign="top">
                    MF Date:
                </td>
                <td valign="top">
                    <uc:RPT_Date ID="ucDT" runat="server" />
                </td>
            </tr>
            <tr class="bgwhite">
                <td>
                    Next Stop:
                </td>
                <td>
                    <asp:TextBox ID="txtNextStop" runat="server" CssClass="input" Text="" MaxLength="5"
                        Width="50" onchange="Javascript:return locTest(this.getAttribute('id'),'loctest');"></asp:TextBox>
                    <input type="button" value="..." runat="server" class="blackfnt" borderstyle="Groove"
                        id="btnAt" onclick="openPopupLoc();" />
                    <div id="Dic_Desc" runat="server" class="boxbg" />
                    <%--<atlas:AutoCompleteExtender runat="server" ID="nextloc" DropDownPanelID="Dic_Desc">
                        <atlas:AutoCompleteProperties TargetControlID="txtNextStop" ServicePath="../AtlasAutoComplete.asmx"
                            ServiceMethod="GetLocation" MinimumPrefixLength="1" Enabled="true" />
                    </atlas:AutoCompleteExtender>--%>
                    <ajaxToolkit:AutoCompleteExtender ID="nextloc" runat="server" Enabled="True"
                        MinimumPrefixLength="1" ServiceMethod="GetLocation" CompletionListItemCssClass="autocomplete_listItem"
                        CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" ServicePath="../AtlasAutoComplete.asmx"
                        TargetControlID="txtNextStop">
                    </ajaxToolkit:AutoCompleteExtender>
                    <asp:Label ID="lblError1" runat="server" Text="Invalid Next Location" Visible="false"
                        CssClass="redfnt"></asp:Label>
                </td>
            </tr>
            <tr class="bgwhite">
                <td colspan="2" align="center">
                    <b>OR</b>
                </td>
            </tr>
            <tr class="bgwhite">
                <td>
                    MF Nos:
                </td>
                <td>
                    <asp:TextBox ID="txtMFNos" runat="server" Width="200"> </asp:TextBox>
                    <i>[Enter coma(,) saperated, if multiple]</i>
                </td>
            </tr>
            <tr class="bgwhite">
                <td colspan="2" align="center">
                    <b>OR</b>
                </td>
            </tr>
            <tr class="bgwhite">
                <td>
                    <%=SessionUtilities.DocketCalledAs %>
                    Nos:
                </td>
                <td>
                    <asp:TextBox ID="txtDockNos" runat="server" Width="200"> </asp:TextBox>
                    <i>[Enter coma(,) saperated, if multiple]</i>
                </td>
            </tr>
            <tr class="bgbluegrey">
                <td colspan="2" align="center">
                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" Width="85" BorderStyle="Groove"
                        OnClick="btnSubmit_Click" />
                </td>
            </tr>
        </table>
        <br />
        <br />
        <asp:GridView ID="gvResult" runat="server" CssClass="mGrid" HeaderStyle-HorizontalAlign="Center"
            RowStyle-HorizontalAlign="Center" AutoGenerateColumns="false" AllowPaging="true"
            AllowSorting="false" PagerSettings-Mode="NumericFirstLast" PagerSettings-Position="TopAndBottom"
            PageSize="25" OnPageIndexChanging="gvResult_PageIndexChanging" Width="800">
            <Columns>
                <asp:TemplateField HeaderText="Sr.No.">
                    <ItemTemplate>
                        <asp:Label ID="lblSrNo" runat="server" Text="<%# Container.DataItemIndex+1 %>"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField HeaderText="MF No" DataField="TCNO" />
                <asp:BoundField HeaderText="MF Date" DataField="TCDT" />
                <asp:BoundField HeaderText="Destination" DataField="ToBH_CODE" />
                <asp:BoundField HeaderText="Total Dockets" DataField="TOT_DKT" ItemStyle-HorizontalAlign="Right" />
                <asp:BoundField HeaderText="Total Packages" DataField="TOT_PKGS" ItemStyle-HorizontalAlign="Right" />
                <asp:BoundField HeaderText="Total Weight" DataField="TOT_ACTUWT" ItemStyle-HorizontalAlign="Right" />
                <asp:HyperLinkField HeaderText="" Text="Edit" DataNavigateUrlFormatString="~/GUI/Operations/Manifest/MF_Edit.aspx?MFNo={0}"
                    DataNavigateUrlFields="TCNO" />
            </Columns>
        </asp:GridView>
    </div>
    <div id="testdiv1" name="testdiv1" style="position: absolute; visibility: hidden;
        background-color: white; layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
