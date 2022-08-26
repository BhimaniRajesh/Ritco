<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="PODUploadException.aspx.cs" Inherits="GUI_Operations_FM_NewPODModules_PODHandoverCriteria"
    Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="javascript" src="../../../images/commonJs.js"></script>
    <script language="javascript" type="text/javascript">
        function ViewPOD() {

            var hdnPOD = $("#<%=hdnPOD.ClientID%>");

            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=800,height=600,status=no,left=60,top=50";
            var strPopupURL = "./../ViewFMScannedDocument.aspx?DocName=" + hdnPOD.val();
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
        <UserControl:UserMessage ID="msgBox" runat="server" />
        <table border="0" align="left" cellpadding="0" cellspacing="0" width="60%">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module </strong></font><strong>&gt; </strong><font
                        class="blklnkund"><strong>Administrator </strong></font><strong>&gt; </strong>
                    <font class="blklnkund"><strong>Operations </strong></font><strong>&gt; </strong>
                    <font class="blklnkund"><strong>DFM </strong></font><strong>&gt; </strong><font class="bluefnt">
                        <strong>POD Upload Exception Module</strong></font>
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
                    <table cellspacing="1" class="boxbg" align="left"  width="80%">
                        <tr class="bgbluegrey">
                            <td colspan="3" align="center" style="height: 21px">
                                <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">POD Upload Exception Module </asp:Label>
                            </td>
                        </tr>
                        <tr  style="background-color: white">
                            <td align="left">
                                <asp:Label ID="Label111" CssClass="blackfnt" Text="Docket Number :" runat="server" Width="100%"></asp:Label>
                            </td>
                            <td align="left" colspan="2" valign="top">
                                <asp:TextBox Text="" ID="txtdocno" runat="server" Width="250"></asp:TextBox>
                            </td>
                        </tr>

                        <tr class="bgbluegrey">
                            <td colspan="3" align="center">
                                <asp:Button ID="btnSubmit" runat="server" Text="Submit" Width="100" OnClick="btnSubmit_Click" /></td>
                        </tr>
                        <tr style="background-color: white">
                            <td colspan="3">&nbsp;</td>
                        </tr>
                        <tr runat="server" class="bgbluegrey" id="tr1" visible="false">
                            <td align="center">
                                <asp:Label ID="Label1" CssClass="blackfnt" Font-Bold="true" Text="Docket Number" runat="server" Width="100%"></asp:Label>
                            </td>
                            <td align="center">
                                <asp:Label ID="Label2" CssClass="blackfnt" Font-Bold="true" Text="OLD POD" runat="server" Width="100%"></asp:Label>
                            </td>
                            <td align="center">
                                <asp:Label ID="Label3" CssClass="blackfnt" Font-Bold="true" Text="New POD" runat="server" Width="100%"></asp:Label>
                            </td>
                        </tr>

                        <tr runat="server" style="background-color: white" id="tr2" visible="false">
                            <td align="left">
                                <asp:Label ID="lblDocketNo" CssClass="blackfnt" Text="Docket Number" runat="server" Width="100%"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:Label ID="lblOldPOD" CssClass="blackfnt" onclick="ViewPOD()" Text="View" runat="server" Width="100%" Font-Underline="true"></asp:Label>
                                <asp:HiddenField ID="hdnPOD" runat="server"></asp:HiddenField>
                            </td>
                            <td align="left">
                                <asp:FileUpload ID="fileUploadPOD" EnableViewState="true" CssClass="input" runat="server" />
                            </td>
                        </tr>
                        <tr runat="server" class="bgbluegrey" id="tr3" visible="false">
                            <td colspan="3" align="center">
                                <asp:Button ID="btnUpload" runat="server" Text="Upload" Width="100" OnClick="btnUpload_Click" /></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
