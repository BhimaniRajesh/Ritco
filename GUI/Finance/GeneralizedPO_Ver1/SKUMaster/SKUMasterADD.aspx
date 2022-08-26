<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="SKUMasterADD.aspx.cs" Inherits="GUI_Finance_GeneralizedPO_SKUMaster_SKUMasterADD" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript" src="../../../images/commonJs.js"></script>

    <script language="javascript" type="text/javascript" src="../../../images/CalendarPopup.js"></script>

    <script language="javascript" type="text/javascript">

        function CheckData() 
        {
			//debugger;
            var grid = document.getElementById("ctl00_MyCPH1_grvcontrols");
            var rows = grid.rows.length;
            var i = 2, x = 0;
            var SKUDesc, MatCat;
            var ChkSel;
            for (i = 2; i <= rows; i++) 
            {
                if (i < 10) 
                {
                    SKUDesc = document.getElementById("ctl00_MyCPH1_grvcontrols_ctl0" + i + "_txtSKUDesc").value;
                    ChkSel = document.getElementById("ctl00_MyCPH1_grvcontrols_ctl0" + i + "_ChkSel").checked;
                    MatCat = document.getElementById("ctl00_MyCPH1_grvcontrols_ctl0" + i + "_ddlMatCat").value;
                }
                else 
                {
                    SKUDesc = document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + i + "_txtSKUDesc").value;
                    ChkSel = document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + i + "_ChkSel").checked;
                    MatCat = document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + i + "_ddlMatCat").value;
                }
                if (ChkSel == true) 
                {
                    x = 1;
                    if (SKUDesc == '') 
                    {
                        alert("Please Enter SKU Description");
                        document.getElementById("ctl00_MyCPH1_grvcontrols_ctl0" + i + "_txtSKUDesc").focus();
                        return false;
                    }
                    if (MatCat == '') 
                    {
                        alert("Please Select the Material Category");
                        document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + i + "_ddlMatCat").focus();
                        return false;
                    }
                }
            }
            if (x == 0) 
            {
                alert("Please Select atleast one Row !!");
                return false;
            }
            //return false;
        } 
    </script>

    <div style="width: 10in; text-align: center">
        <table cellspacing="1" class="boxbg" style="width: 10in; text-align: center">
            <tr class="bgbluegrey">
                <td align="center">
                    <strong>ADD SKU Master Details</strong>
                </td>
            </tr>
        </table>
        <br />
        <%--<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" RenderMode="Inline">
            <ContentTemplate>--%>
        <table id="tblAddRow" runat="server" border="0" cellpadding="3" cellspacing="1" class="boxbg"
            style="background-color: #808080">
            <tr style="background-color: #ffffff">
                <td align="left" class="blackfnt" width="50%">
                    <b>Enter No. of Rows</b>
                </td>
                <td align="left" class="blackfnt" width="50%">
                    <asp:TextBox ID="txtnorows" runat="server">5</asp:TextBox>
                    <asp:Button ID="btnrows" runat="server" OnClick="btnrows_Click" Text="Add Rows" />
                </td>
            </tr>
        </table>
        <br />
        <table border="0" cellpadding="3" cellspacing="1" class="boxbg" style="background-color: #808080;
            text-align: center" width="100%">
            <tr class="bgbluegrey">
                <td align="center" class="blackfnt">
                    <b>Enter the SKU Details</b>
                </td>
            </tr>
            <tr style="background-color: #ffffff;">
                <td align="center" class="blackfnt">
                    <asp:GridView ID="grvcontrols" runat="server" AutoGenerateColumns="False" BorderWidth="0px"
                        CellSpacing="1" CssClass="boxbg" EmptyDataText="No Records Found..." FooterStyle-CssClass="boxbg"
                        OnRowDataBound="GvDocketDetails_RowDataBound" Width="60%">
                        <FooterStyle CssClass="boxbg" />
                        <Columns>
                            <asp:TemplateField HeaderText="Select">
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="White" />
                                <HeaderStyle CssClass="blackfnt" BackColor="#D4E0E7" HorizontalAlign="Center" Wrap="False"
                                    Font-Bold="true" />
                                <ItemTemplate>
                                    <asp:CheckBox ID="ChkSel" runat="server" Text="<%# Container.DataItemIndex+1 %>" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Mat Category">
                                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False"
                                    Font-Bold="true" />
                                <ItemTemplate>
                                    <asp:DropDownList ID="ddlMatCat" runat="server">
                                    </asp:DropDownList>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="SKU Desc">
                                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False"
                                    Font-Bold="true" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txtSKUDesc" onkeypress="javascript:return withoutQuote(event)" runat="server" BorderStyle="Groove" Width="100px" Enabled="true"></asp:TextBox>
									<asp:RegularExpressionValidator ID="revSKUdesc" runat="server" ControlToValidate="txtSKUDesc" 
                                         ValidationExpression="[a-zA-Z0-9\s.]*" Display="Dynamic" ErrorMessage="Special Character Not Allow" CssClass="redfnt"></asp:RegularExpressionValidator>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Manufacture">
                                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False"
                                    Font-Bold="true" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txtManufacture" onkeypress="javascript:return withoutQuote(event)" runat="server" BorderStyle="Groove" Width="100px"
                                        Enabled="true"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Part No">
                                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False"
                                    Font-Bold="true" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txtSKUType" onkeypress="javascript:return withoutQuote(event)" runat="server" BorderStyle="Groove" Width="100px"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="SKU Size">
                                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False"
                                    Font-Bold="true" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txtSKUSize" onkeypress="javascript:return withoutQuote(event)" runat="server" BorderStyle="Groove" Enabled="true"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="UOM">
                                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False"
                                    Font-Bold="true" />
                                <ItemTemplate>
                                    <asp:DropDownList ID="ddlUOM" runat="server" DataTextField="CodeDesc" DataValueField="CodeId">
                                        <%--<asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="Nos." Value="1"></asp:ListItem>
                                        <asp:ListItem Text="Kgs." Value="2"></asp:ListItem>
                                        <asp:ListItem Text="Meter." Value="3"></asp:ListItem>
                                        <asp:ListItem Text="Liter." Value="4"></asp:ListItem>
                                        <asp:ListItem Text="PCs." Value="5"></asp:ListItem>
                                        <asp:ListItem Text="Bundle." Value="6"></asp:ListItem>
                                        <asp:ListItem Text="Boxes." Value="7"></asp:ListItem>
                                        <asp:ListItem Text="Books." Value="8"></asp:ListItem>
                                        <asp:ListItem Text="Dozen." Value="9"></asp:ListItem>
                                        <asp:ListItem Text="Pakets." Value="10"></asp:ListItem>--%>
                                    </asp:DropDownList>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Remark">
                                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False"
                                    Font-Bold="true" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txtRemark" onkeypress="javascript:return withoutQuote(event)" runat="server" TextMode="MultiLine" BorderStyle="Groove"
                                        Width="250px" Enabled="true"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Active">
                                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False"
                                    Font-Bold="true" />
                                <ItemTemplate>
                                    <asp:CheckBox ID="ChkActive" runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="UDF 1">
                                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False"
                                    Font-Bold="true" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txtUDF1" onkeypress="javascript:return withoutQuote(event)" runat="server" BorderStyle="Groove" Enabled="true"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="UDF 2">
                                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False"
                                    Font-Bold="true" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txtUDF2" onkeypress="javascript:return withoutQuote(event)" runat="server" BorderStyle="Groove" Enabled="true"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="UDF 3">
                                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False"
                                    Font-Bold="true" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txtUDF3" onkeypress="javascript:return withoutQuote(event)" runat="server" BorderStyle="Groove" Enabled="true"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="UDF 4">
                                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False"
                                    Font-Bold="true" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txtUDF4" onkeypress="javascript:return withoutQuote(event)" runat="server" BorderStyle="Groove" Enabled="true"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="UDF 5">
                                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False"
                                    Font-Bold="true" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txtUDF5" onkeypress="javascript:return withoutQuote(event)" runat="server" BorderStyle="Groove" Enabled="true"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <PagerStyle HorizontalAlign="Left" />
                    </asp:GridView>
                </td>
            </tr>
            <tr style="background-color: #ffffff">
                <td class="bgbluegrey" style="text-align: center">
                    <asp:Button ID="btnsubmit" runat="server" Text="Submit" OnClick="btnsubmit_Click"
                        OnClientClick="javascript:return CheckData();" />
                    <%--OnClick="btnsubmit_Click" OnClientClick="javascript:return CheckData();"--%>
                    <asp:HiddenField ID="HidLastSKUCode" runat="server" />
                    <asp:HiddenField ID="hidFrom" runat="server" />
                    <asp:HiddenField ID="hidDate" runat="server" />
                    <asp:HiddenField ID="hidManualNo" runat="server" />
                </td>
            </tr>
        </table>
        <%--            </ContentTemplate>
        </asp:UpdatePanel>--%>
    </div>
</asp:Content>
