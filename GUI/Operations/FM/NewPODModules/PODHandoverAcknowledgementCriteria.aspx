<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="PODHandoverAcknowledgementCriteria.aspx.cs" Inherits="GUI_Operations_FM_NewPODModules_PODHandoverAcknowledgementCriteria" %>
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
    
        function View(ctrl) {
            var lnkView = $(ctrl);
            var hdnPODNo = $("#" + $(ctrl).attr('id').replace("lnkView", "hdnPODNo"));
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=800,height=600,status=no,left=60,top=50";
            var strPopupURL = "PODHandoverAcknowledgementResult.aspx?PODNo=" + hdnPODNo.val();
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
                        <strong>POD Handover Acknowledgement Criteria Module</strong></font>
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
                                <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">POD Handover Acknowledgement Module </asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left">
                               <%-- <font class="blackfnt">Branch Name</font>--%>
                            </td>
                            <td align="left">
                                 <Location:LH ID="Fromlc" runat="server" />
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
                                <asp:Label ID="Label111" CssClass="blackfnt" Text="Enter POD Handover Number:" runat="server"
                                    Width="100%"></asp:Label>
                            </td>
                            <td align="left" valign="top">
                                <asp:TextBox Text="" ID="txtPODNo" runat="server" Width="250"></asp:TextBox>
                                <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                            </td>
                        </tr>

                        <tr class="bgbluegrey">
                            <td colspan="2" align="center">
                                <asp:Button ID="btnSubmit" runat="server" Text="Submit" Width="100" OnClientClick="Javascript: return ValidateData();" OnClick="btnSubmit_Click"/></td>
                        </tr>
                        <tr class="bgbluegrey">
                            <td colspan="2" align="center">
                                    <asp:GridView ID="dgDockets" runat="server" CellSpacing="1" CellPadding="3"
                                    AllowSorting="true" AutoGenerateColumns="false" CssClass="dgRowStyle" EmptyDataText="No Records Found..."
                                    Width="100%">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Sl No." ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                            <ItemTemplate>
                                               <asp:Label ID="lnSlNo" runat="server" Text ="<%#Container.DataItemIndex+1%>" CssClass="bluefnt" Font-Underline="false" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="POD Handover Number" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                            <ItemTemplate>
                                                <asp:HiddenField ID="hdnPODNo" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "PODNo")%>' />
                                                <asp:Label ID="lnkPODNo" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "PODNo")%>' CssClass="blackfnt" Font-Underline="false" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Number Of GR's" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                            <ItemTemplate>
                                                <asp:HiddenField ID="hdnNoOfGrn" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "NoOfGrn")%>' />
                                                <asp:Label ID="lnkNoOfGrn" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "NoOfGrn")%>' CssClass="blackfnt" Font-Underline="false" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Date Of Handover" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                            <ItemTemplate>
                                                <asp:HiddenField ID="hdnDtOfHandover" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "DtOfHandover")%>' />
                                                <asp:Label ID="lnkDtOfHandove" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "DtOfHandover")%>' CssClass="blackfnt" Font-Underline="false" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Action" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                            <ItemTemplate>
                                                <u><asp:Label ID="lnkView" onclick="View(this);" runat="server" Width="65" Text='View'></asp:Label></u>
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
