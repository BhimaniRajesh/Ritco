<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="PODHandoverReprint.aspx.cs" Inherits="GUI_Operations_FM_NewPODModules_PODHandoverReprint"
    Title="Untitled Page" %>

<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<%@ Register TagName="LH" TagPrefix="Location" Src="~/GUI/Common_UserControls/LocationHirarchy.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="JavaScript" src="../../../Images/CalendarPopup.js"></script>
    <script language="javascript" src="../../../images/commonJs.js"></script>
    <script language="JavaScript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();

        function ValidateData() {
            return DateCheck();
        }
    
        function ViewPrint(ctrl) {
            var lnkPrint = $(ctrl);
            var hdnPDHNo = $("#" + $(ctrl).attr('id').replace("lnkPrint", "hdnPDHNo"));
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=800,height=600,status=no,left=60,top=50";
            var strPopupURL = "PODHandover_ViewPrint.aspx?PDHNo=" + hdnPDHNo.val();
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
    </script>

    <asp:UpdateProgress ID="uppMain" runat="server">
        <ProgressTemplate>
            <iframe frameborder="0" src="about:blank" style="border: 0px; position: absolute; z-index: 9; left: 0px; top: 0px; width: expression(this.offsetParent.scrollWidth); height: expression(this.offsetParent.scrollHeight); filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);"></iframe>
            <div style="position: absolute; z-index: 10; left: expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft); top: expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);">
                <img src="../../../images/loading.gif" /><font face="verdana" color="blue" size="4">&nbsp;<b>Please
                    Wait...</b></font>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <div align="left">
        <table border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module </strong></font><strong>&gt; </strong><font
                        class="blklnkund"><strong>Administrator </strong></font><strong>&gt; </strong>
                    <font class="blklnkund"><strong>Operations </strong></font><strong>&gt; </strong>
                    <font class="blklnkund"><strong>DFM </strong></font><strong>&gt; </strong><font class="bluefnt">
                        <strong>POD Handover Reprint Module</strong></font>
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="../../../images/clear.gif" width="2" height="1" /></td>
            </tr>
            <tr>
                <td>
                    <img src="../../../images/clear.gif" width="15" height="10" /></td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>
                    <table cellspacing="1" class="boxbg" align="left">
                        <tr class="bgbluegrey">
                            <td colspan="2" align="center" style="height: 21px">
                                <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">POD Handover Reprint Module </asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left">
                                <font class="blackfnt">Branch Name</font>
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlLocation" runat="server" AutoPostBack="false" EnableViewState="true"
                                    DataTextField="LocName" DataValueField="LocCode" />
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left" valign="top" width="104">
                                <asp:Label ID="Label2" CssClass="blackfnt" Text="Select Date" runat="server"></asp:Label>
                            </td>
                            <td align="left" valign="top">
                                <Date:DT ID="DT" runat="server" />
                            </td>
                        </tr>
                        <tr bgcolor="white" align="center">
                            <td colspan="2">
                                <font class="blackboldfnt">OR </font>
                            </td>
                        </tr>
                        <tr id="Tr111" visible="true" runat="server" style="background-color: white">
                            <td align="left">
                                <asp:Label ID="Label111" CssClass="blackfnt" Text="POD Handover Number :" runat="server"
                                    Width="100%"></asp:Label>
                            </td>
                            <td align="left" valign="top">
                                <asp:TextBox Text="" ID="txtdocno" runat="server" Width="250"></asp:TextBox>
                                <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                            </td>
                        </tr>

                        <tr class="bgbluegrey">
                            <td colspan="2" align="center">
                                <asp:Button ID="btnSubmit" runat="server" Text="Submit" Width="100" OnClientClick="Javascript: return ValidateData();" OnClick="btnSubmit_Click" /></td>
                        </tr>
                        <tr class="bgbluegrey">
                            <td colspan="2" align="center">
                                    <asp:GridView ID="dgDockets" runat="server" CellSpacing="1" CellPadding="3"
                                    AllowSorting="true" AutoGenerateColumns="false" CssClass="dgRowStyle" EmptyDataText="No Records Found..."
                                    Width="100%">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Handover Number" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                            <ItemTemplate>
                                                <asp:HiddenField ID="hdnPDHNo" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "PDHNo")%>' />
                                                <asp:Label ID="lnkPDHNo" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "PDHNo")%>' CssClass="bluefnt" Font-Underline="false" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Number of GR's" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lnkDocketCnt" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "DktCnt")%>' CssClass="blackfnt" Font-Underline="false" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Date of Handover" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lnkHandoverDate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "HandoverDate")%>' CssClass="bluefnt" Font-Underline="false" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Handover Done By" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lnkEntryBy" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "EntryBy")%>' CssClass="blackfnt" Font-Underline="false" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Print" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                            <ItemTemplate>
                                                <u><asp:Label ID="lnkPrint" onclick="ViewPrint(this);" runat="server" Width="65" Text='Print'></asp:Label></u>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                    </Columns>
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
