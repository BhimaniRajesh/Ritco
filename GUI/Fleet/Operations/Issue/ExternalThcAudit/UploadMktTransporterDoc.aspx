<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="UploadMktTransporterDoc.aspx.cs" Inherits="GUI_Fleet_Operations_Issue_ExternalThcAudit_UploadMktTransporterDoc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
<script language="javascript" type="text/javascript">
    function Submitdata() {
        Form_name = "ctl00$MyCPH1$"
        var rows = document.getElementById("ctl00_MyCPH1_myGrid").rows.length
        var maxrows = document.getElementById("ctl00_MyCPH1_myGrid").rows.length
        var onecheck = false
        for (i = 0; i < rows - 1; i++) {
            j = i + 2
            if (j < 10) {
                
                if (document.getElementById("ctl00_MyCPH1_myGrid_ctl0" + j + "_txtExternalThcNo").value == "") {
                    alert("Please Enter POD no. !!!!")
                    document.getElementById("ctl00_MyCPH1_myGrid_ctl0" + j + "_txtExternalThcNo").focus();
                    return false;
                }
                if (document.getElementById("ctl00_MyCPH1_myGrid_ctl0" + j + "_fileUpload").value == "") {
                    alert("Please File to Upload !!!!")
                    document.getElementById("ctl00_MyCPH1_myGrid_ctl0" + j + "_fileUpload").focus();
                    return false;
                }
            }
            else {
                
                if (document.getElementById("ctl00_MyCPH1_myGrid_ctl" + j + "_txtExternalThcNo").value == "") {
                    alert("Please Enter POD no. !!!!")
                    document.getElementById("ctl00_MyCPH1_myGrid_ctl" + j + "_txtExternalThcNo").focus();
                    return false;
                }

                if (document.getElementById("ctl00_MyCPH1_myGrid_ctl" + j + "_fileUpload").value == "") {
                    alert("Please File to Upload !!!!")
                    document.getElementById("ctl00_MyCPH1_myGrid_ctl" + j + "_fileUpload").focus();
                    return false;
                }
            }
        }
    }
    </script>
    <asp:UpdateProgress ID="uppMain" runat="server">
        <ProgressTemplate>
            <iframe frameborder="0" src="about:blank" style="border: 0px; position: absolute;
                z-index: 9; left: 0px; top: 0px; width: expression(this.offsetParent.scrollWidth);
                height: expression(this.offsetParent.scrollHeight); filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);">
            </iframe>
            <div style="position: absolute; z-index: 10; left: expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);
                top: expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);">
                <img src="../../../../images/loading.gif" /><font face="verdana" color="blue" size="4">&nbsp;<b>Please
                    Wait...</b></font></div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <table border="0" align="left" cellpadding="0" cellspacing="0" class="blackfnt">
        <tr>
            <td height="30">
                <font class="blklnkund"><strong>Trip Sheet </strong></font><strong>&gt; </strong>
                <font class="blklnkund"><strong>Operations </strong></font> <strong>&gt; </strong>
                <font class="blklnkund"><strong>External Thc </strong></font><strong>&gt; </strong>
                <font class="bluefnt"><strong>Scan Documents For Market Transporter</strong></font>
            </td>
        </tr>
        <tr>
            <td class="horzblue">
                <img src="../../../../images/clear.gif" width="2" height="1" /></td>
        </tr>
        <tr>
            <td>
                <img src="../../../../images/clear.gif" width="15" height="10" /></td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                <table border="0" cellpadding="0" style="width: 9.0in" cellspacing="1" class="boxbg">
                    <tr bgcolor="#ffffff">
                        <td align="right" style="width: 25%" class="blackfnt">
                            No of Rows :
                        </td>
                        <td align="left" style="width: 25%" valign="middle">
                            <asp:UpdatePanel ID="id2" runat="server"   UpdateMode="Always" RenderMode="Inline">
                                <ContentTemplate>
                                    <asp:TextBox ID="txtnorwos" Width="50px" AutoPostBack="true" OnTextChanged="txtnorwos_TextChanged"
                                        runat="server"></asp:TextBox>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td colspan="4" class="blackfnt">
                            <asp:UpdatePanel ID="id1" runat="server"  UpdateMode="Always" RenderMode="Inline">
                                <ContentTemplate>
                                    <asp:DataGrid ID="myGrid" runat="server" Width="100%" AutoGenerateColumns="False"
                                        CellPadding="1" CellSpacing="1" GridLines="Both" BorderWidth="0" CssClass="boxbg"
                                        HeaderStyle-CssClass="bgbluegrey" OnItemDataBound="myGrid_ItemDataBound">
                                        <Columns>
                                            <asp:TemplateColumn HeaderText="External Thc No">
                                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" HorizontalAlign="Center" VerticalAlign="Middle" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" HorizontalAlign="Center" VerticalAlign="Middle" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtExternalThcNo" OnTextChanged="txtExternalThcNo_TextChanged" runat="server"
                                                        AutoPostBack="true" CssClass="input"></asp:TextBox>
                                                    <asp:Label class="blackfnt" ID="lblExternalThcNo" runat="server" Style="color: Red;" Visible="false"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="Scan Status">
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" HorizontalAlign="Center" VerticalAlign="Middle" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="lblScanStatus" runat="server" class="blackfnt" Visible="false"></asp:TextBox>
                                                    <asp:Label ID="lblScanStatus_new" runat="server" class="blackfnt" Visible="true"
                                                        Text="Not Scanned"></asp:Label>
                                                    <asp:HyperLink ID="hylView" runat="server" Visible="false" Text="View" Font-Underline="true"
                                                        Target="_blank" CssClass="bluefnt"></asp:HyperLink>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="Select Document">
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" HorizontalAlign="Center" VerticalAlign="Middle" />
                                                <ItemTemplate>
                                                    <asp:FileUpload ID="fileUpload" EnableViewState="true" CssClass="input" runat="server" />
                                                    <asp:Label ID="lblUloadLink" runat="server" class="blackfnt" Visible="false" Text="Not Scanned"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                        </Columns>
                                        <ItemStyle BackColor="white" HorizontalAlign="Center" />
                                        <AlternatingItemStyle BackColor="#f7f7f7" HorizontalAlign="Center" />
                                    </asp:DataGrid>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="txtnorwos" EventName="TextChanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td colspan="2" align="center">
                            <asp:Button ID="btnSubmit" OnClientClick="return Submitdata()" runat="server" Text="Submit"
                                ToolTip="Click here to complete scan document(s) process" OnClick="btnSubmit_Click" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblMsg" runat="server"></asp:Label>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>