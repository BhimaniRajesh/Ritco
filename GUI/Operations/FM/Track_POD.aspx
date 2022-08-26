<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Track_POD.aspx.cs" Inherits="GUI_Operations_FM_Track_POD" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

<script type="text/javascript" language="JavaScript">

function ViewPrint(arg1,arg2,arg3)
{
    window.open("../PFM/pfm_print.aspx?strPFMNo=" + arg1 + "," + arg2 + "," + arg3 ,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=700,height=350,status=no,left=60,top=125");
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
                <img src="../../images/loading.gif" /><font face="verdana" color="blue" size="4">&nbsp;<b>Please
                    Wait...</b></font></div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
            <td height="30">
                <font class="blklnkund"><strong>Module </strong></font> <strong>&gt; </strong>
                <font class="blklnkund"><strong>Administrator </strong></font><strong>&gt; </strong>
                <font class="blklnkund"><strong>Operations </strong></font> <strong>&gt; </strong>
                <font class="blklnkund"><strong>DFM </strong></font><strong>&gt; </strong>                
                <font class="bluefnt"><strong>Documents Track </strong></font>
            </td>
        </tr>
        <tr>
            <td class="horzblue">
                <img src="../../images/clear.gif" width="2" height="1"></td>
        </tr>
        <tr>
            <td>
                <img src="../../images/clear.gif" width="15" height="10" /></td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td height="300" valign="top">
                <center>
                    <br />
                    <table border="0" class="boxbg" cellspacing="1" cellpadding="1" style="width: 6.5in">
                        <tr class="bgbluegrey">
                            <td align="center" colspan="2">
                                <label class="blackfnt">
                                    <b>Documents Track </b>
                                </label>
                            </td>
                        </tr>
                        <tr bgcolor="white">
                            <td>
                                <asp:Label ID="dktcall" Text="Enter" runat="server" CssClass="blackfnt"></asp:Label>
                                <asp:DropDownList ID="ddlDocType" runat="server" CssClass="input">
                                </asp:DropDownList>
                                <asp:Label ID="Label1" Text="No." runat="server" CssClass="blackfnt"></asp:Label>
                            </td>
                            <td>
                                <asp:UpdatePanel ID="upSubmit" runat="server">
                                    <ContentTemplate>
                                        <asp:TextBox ID="txtdktno" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ControlToValidate="txtdktno" ValidationGroup="onSubmit" ToolTip="Required"></asp:RequiredFieldValidator>
                                        <label class="blackfnt">
                                            &nbsp;
                                        </label>
                                        <asp:Button ID="btnSubmit" runat="server" Text="Track" OnClick="btnSubmit_Click" ValidationGroup="onSubmit"/>
                                        <label class="blackfnt">
                                            &nbsp;
                                        </label>
                                        <asp:Button ID="btnXLS" runat="server" Text="Download XLS" OnClick="btnXLS_Click" ValidationGroup="onSubmit"/>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                    </table>
                </center>
                <br />
                <asp:UpdatePanel ID="u1"  UpdateMode="Conditional" runat="server">
                    <ContentTemplate>
                        <asp:GridView align="center" ID="dgDocket" runat="server" CellSpacing="1" CellPadding="2" GridLines="none"
                            HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true"
                            AllowPaging="false" PagerStyle-HorizontalAlign="Center" CssClass="boxbg" FooterStyle-CssClass="boxbg"
                            Width="9.0in" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
                            PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found...">
                            <Columns>
                                <asp:TemplateField HeaderText="SR.NO.">
                                    <ItemTemplate>
                                        <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>"
                                            runat="server">
                                        </asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle CssClass="blackfnt" />
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="PFM No.">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" Width="120" />
                                    <ItemStyle CssClass="bluefnt" BackColor="white" />
                                    <ItemTemplate>
                                        <a href="JavaScript:ViewPrint('<%#DataBinder.Eval(Container.DataItem, "fm_no") %>','<%#DataBinder.Eval(Container.DataItem, "fm_doc_type") %>',0)">
                                            <font cssclass="bluefnt"><u>
                                                <%#DataBinder.Eval(Container.DataItem, "fm_no")%>
                                            </u></font></a>
                                    </ItemTemplate>
                                    <ItemStyle CssClass="bluefnt" HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="fmdt" HeaderText="PFM Date">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:BoundField DataField="fromloc" HeaderText="From">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:BoundField DataField="toLoc" HeaderText="TO">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Ack_Date" HeaderText="Acknowledge Date">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                            </Columns>
                            <RowStyle BackColor="white" Wrap="false" />
                            <PagerStyle HorizontalAlign="Center" BackColor="white" />
                            <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                            <FooterStyle CssClass="boxbg" />                        
                        </asp:GridView>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnSubmit" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
            </td>
        </tr>
    </table>
</asp:Content>
