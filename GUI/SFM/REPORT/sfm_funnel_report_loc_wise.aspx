<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="sfm_funnel_report_loc_wise.aspx.cs" Inherits="REPORT_sfm_funnel_report_loc_wise" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<table style="width:100%">

        <tr>
            <td align="left"  colspan="3">
                <asp:Label ID="lblWelcome" runat="server" Text="Funnel-Location Wise Report" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                <hr align="center" size="1" color="#8ba0e5" />
            </td>
        </tr>
        </table>

    <div align="left">
            <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg"
                                                    colspan="2" style="width:8.1in">
                                                    <tr class="bgbluegrey">
                                                        <td align="center" colspan="3">
                                                            <font class="blackfnt"><strong>Select Report Criteria </strong></font>
                                                        </td>
                                                    </tr>
                                                    <tr bgcolor="#ffffff">
                                                        <td align="left">
                                                            <div align="left">
                                                                <font class="blackfnt">Select RO</font> :
                                                            </div>
                                                        </td>
                                                        <td align="left" bgcolor="#ffffff" colspan="2">
                                                            <asp:UpdatePanel ID="updatepanel2" runat="server">
                                                                <ContentTemplate>
                                                                    <asp:DropDownList ID="cboSelectRo" runat="server" AutoPostBack="true" 
                                                                        OnSelectedIndexChanged="cboSelectRo_SelectedIndexChanged">
                                                                        <asp:ListItem Text="--All--" Value=""></asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </ContentTemplate>
                                                                
                                                            </asp:UpdatePanel>
                                                        </td>
                                                    </tr>
                                                    
                                                    <tr bgcolor="#ffffff">
                                                        <td valign="top" align ="left" >
                                                            <font class="blackfnt">Select Date </font>
                                                        </td>
                                                        <td align="left">
                                                            <asp:UpdatePanel ID="UpdatePanel3"     UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                <ContentTemplate>
                                    <asp:RadioButtonList ID="radDate" runat="server" ValidationGroup="VGDtFromTo" CssClass="blackfnt"
                                        AutoPostBack="true" OnSelectedIndexChanged="radDate_OnSelectedIndexChange">
                                        <asp:ListItem Selected="True" Value="0" Text=" Date Range [dd/mm/yyyy]"></asp:ListItem>
                                        <asp:ListItem Selected="false" Value="1" Text=" Last Week (Including Today)"></asp:ListItem>
                                        <asp:ListItem Selected="false" Value="2" Text=" Today:"></asp:ListItem>
                                        <asp:ListItem Selected="false" Value="3" Text=" Till Date:"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                                                        </td>
                                                        
                                                        <td valign="top" align="left">
                            <asp:UpdatePanel ID="UpdatePanel4" RenderMode="Inline"    UpdateMode="Conditional" runat="server">
                                <ContentTemplate>
                                    <asp:Label ID="lblFrom" CssClass="blackfnt" runat="server" Text=" From: "></asp:Label>
                                    <asp:TextBox ID="txtDateFrom" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                    <asp:Label ID="lblTo" CssClass="blackfnt" runat="server" Text=" To: "></asp:Label>
                                    <asp:TextBox ID="txtDateTo" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                    </br>
                                    <asp:RequiredFieldValidator ID="RFVFromDate" runat="server" ControlToValidate="txtDateFrom"
                                        ErrorMessage="Date From cannot be blank :(" CssClass="blackfnt" ValidationGroup="VGDtFromTo" />
                                    </br>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid Date From  :("
                                        ControlToValidate="txtDateFrom" ValidationGroup="VGDtFromTo" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                                    </br>
                                    <asp:RequiredFieldValidator ID="RFVToDate" runat="server" ControlToValidate="txtDateTo"
                                        ErrorMessage="Date To cannot be blank :(" CssClass="blackfnt" ValidationGroup="VGDtFromTo" />
                                    </br>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Invalid Date To  :("
                                        ControlToValidate="txtDateTo" ValidationGroup="VGDtFromTo" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="radDate" EventName="SelectedIndexChanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </td>
                                                    </tr>
                                                    
                                                    <tr bgcolor="#ffffff">
                                                        <td align="left">
                                                            <div align="left">
                                                                <font class="blackfnt">Select Location</font> :
                                                            </div>
                                                        </td>
                                                        <td align="left" bgcolor="#ffffff" colspan="2">
                                                            <div id="LocationCombo">
                                                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                                    <ContentTemplate>
                                                                        <asp:DropDownList ID="cboSelectLocation" runat="server" AutoPostBack="true" 
                                                                             OnSelectedIndexChanged="cboSelectLocation_SelectedIndexChanged">
                                                                            <asp:ListItem Text="--All--" Value=""></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </ContentTemplate>
                                                                    <Triggers>
                                                                        <asp:AsyncPostBackTrigger ControlID="cboSelectRo" EventName="SelectedIndexChanged" />
                                                                    </Triggers>
                                                                </asp:UpdatePanel>
                                                                </div>
                                                        </td>
                                                    </tr>
                                                    
                                                    
                                                    <tr class="bgbluegrey" style="font-weight: bold; font-size: 12pt; font-family: Times New Roman">
                                                        <td align="Center" colspan="3">
                                                            <font class="blackfnt"><strong>OR</strong> </font>
                                                        </td>
                                                    </tr>
                                                    <tr bgcolor="#ffffff" style="font-weight: bold; font-size: 12pt; font-family: Times New Roman">
                                                        <td align="left">
                                                            <font class="blackfnt">Enter Location Code</font></td>
                                                        <td valign="top" align ="left" colspan="2">
                                                            <asp:TextBox ID="txtLocationCode" runat="server" Width="50"></asp:TextBox>&nbsp;
                                                            <%--<asp:Button ID="btnPopUp" runat="server"  Width="32px" />--%>
                                                            <input type="button" id="btnPopUp" value="..." runat="server" />
                                                            </td>
                                                    </tr>
                                                    
                                                    
                                                </table>
                                                <br />
                                                <table  border="0" cellpadding="3" cellspacing="1" style="width:9.5in">
                                                    <tr >
                                                        <td align ="center" colspan="3">
                                                        <asp:Button ID="btnShowReport" runat="server" Text="Show Report" Width="96px" OnClick="btnShowReport_Click" /></td>
                                                    </tr>
                                                    </table>
                                                    
                                                    <table cellspacing="1" style="width:9.5in">
        <tr align="center">
            <td align="center">
                <asp:UpdatePanel ID="u1"  UpdateMode="Conditional" runat="server">
                    <ContentTemplate>
                        
                         
                  <table id="headingtable" 
    style="FONT-WEIGHT: bold; COLOR: #244668" borderColor="#000033"
    height="100%" cellspacing="0" 
    cellpadding="0" border="0" runat="server">
<tr>
    <td><asp:DataGrid ID="dgCallSummary" runat="server" BorderWidth="1" CellSpacing="1" CellPadding="5" HeaderStyle-CssClass="bgbluegrey" HeaderStyle-Font-Bold="true"
                                BorderColor="#8ba0e5" AllowPaging="true" CssClass="blackfnt"   AutoGenerateColumns="false" OnPageIndexChanged="pgChange">
                             <ItemStyle Height="30px" VerticalAlign="Top"/>
                             <AlternatingItemStyle Height="30px"/>
                             <PagerStyle Mode="NumericPages" />
                             <HeaderStyle />
                             <Columns><asp:TemplateColumn ItemStyle-BorderColor="#000033" 
            ItemStyle-Width="25Px" ItemStyle-Wrap="True" 
            HeaderStyle-CssClass="bgbluegrey">
        <HeaderTemplate>Location
    </td>
    <td width="500"  colspan="2" 
           align="center">HOT</td>
    <td width="500"  colspan="2" 
           align="center">WARM</td>
    <td width="500"  colspan="2" 
           align="center">COLD</td>
    <td width="500"  colspan="2" 
           align="center">ALL</td>
</tr><td align="Center" height="25px" 
       class="GrdHeaderStyle" ></td>
</HeaderTemplate>
<ItemTemplate>
    <asp:Label ID="location" Text='<%# DataBinder.Eval(Container.DataItem,"loccode") %>' runat="server"></asp:Label>
</ItemTemplate>
</asp:TemplateColumn>
<asp:TemplateColumn HeaderText="Prospects" HeaderStyle-CssClass="GrdHeaderStyle" 
       ItemStyle-Width="75Px" ItemStyle-Wrap="True" 
       ItemStyle-CssClass="GrdItemStyle">
    <ItemTemplate>
    
    <label class="blackfnt">
    <asp:HyperLink  Runat="server"  Font-Underline="True"  CssClass="blackfnt"  NavigateUrl='<%#"sfm_funnel_report_locwise_2.aspx?pro=" +DataBinder.Eval(Container.DataItem, "HotKount")+"&calltype="+"HOT"+"&value="+DataBinder.Eval(Container.DataItem, "HotWalue")%>' Text= '<%#DataBinder.Eval(Container.DataItem, "HotKount")%>' ID="Hyperlink1">
    </asp:HyperLink>
   </label>
        <%--<asp:Label ID="lblCompanyName"  Width="75Px" 
             Runat="server" 
             text='<%# DataBinder.Eval(Container.DataItem,"HotKount") %>'>
        </asp:Label>--%>
        </ItemTemplate>
    </asp:TemplateColumn>
    <asp:TemplateColumn HeaderText="Value" 
            HeaderStyle-CssClass="GrdHeaderStyle" 
            ItemStyle-Width="75Px" ItemStyle-Wrap="True" 
            ItemStyle-CssClass="GrdItemStyle">
        <ItemTemplate>
            <asp:Label ID="lblWebSiteName" Width="75Px" 
                  Runat="server" 
                  text='<%# DataBinder.Eval(Container.DataItem,"HotWalue") %>'>
            </asp:Label>
        </ItemTemplate>
    </asp:TemplateColumn>
    <asp:TemplateColumn HeaderText="Prospects" 
                HeaderStyle-CssClass="GrdHeaderStyle" 
                ItemStyle-Width="75Px" ItemStyle-Wrap="True" 
                ItemStyle-CssClass="GrdItemStyle">
        <ItemTemplate>
        <label class="blackfnt">
    <asp:HyperLink  Runat="server"  Font-Underline="True"  CssClass="blackfnt"  NavigateUrl='<%#"sfm_funnel_report_locwise_2.aspx?calltype=WARM"%>' Text= '<%#DataBinder.Eval(Container.DataItem, "WarmKount")%>' ID="Hyperlink1">
    </asp:HyperLink>
    </label>
            <%--<asp:Label ID="lblContactPersonName" Width="75Px" 
                Runat="server" 
                text='<%# DataBinder.Eval(Container.DataItem,"WarmKount") %>'>
            </asp:Label>--%>
        </ItemTemplate>
    </asp:TemplateColumn>
    <asp:TemplateColumn HeaderText="Value" 
            HeaderStyle-CssClass="GrdHeaderStyle" 
            ItemStyle-Width="75Px"
            ItemStyle-Wrap="True" 
            ItemStyle-CssClass="GrdItemStyle">
        <ItemTemplate>
            <asp:Label ID="lblBillno" Width="75px" 
                Runat="server" 
                text='<%# DataBinder.Eval(Container.DataItem,"WarmWalue") %>'>
            </asp:Label>
        </ItemTemplate>
    </asp:TemplateColumn>
    <asp:TemplateColumn HeaderText="Prospects" 
          HeaderStyle-CssClass="GrdHeaderStyle" 
          ItemStyle-Width="75Px" ItemStyle-Wrap="True" 
          ItemStyle-CssClass="GrdItemStyle">
        <ItemTemplate>
        <label class="blackfnt">
    <asp:HyperLink  Runat="server"  Font-Underline="True"  CssClass="blackfnt"  NavigateUrl='<%#"sfm_funnel_report_locwise_2.aspx?calltype=COLD"%>' Text= '<%#DataBinder.Eval(Container.DataItem, "ColdKount")%>' ID="Hyperlink1">
    </asp:HyperLink>
    </label>
            <%--<asp:Label ID="lblBillDate" Width="75Px" 
               Runat="server" 
               text='<%# DataBinder.Eval(Container.DataItem,"ColdKount") %>'>
            </asp:Label>--%>
        </ItemTemplate>
    </asp:TemplateColumn>
    <asp:TemplateColumn HeaderText="Value" 
          HeaderStyle-CssClass="GrdHeaderStyle" 
          ItemStyle-Width="75Px"
          ItemStyle-Wrap="True" ItemStyle-CssClass="GrdItemStyle">
        <ItemTemplate>
            <asp:Label ID="lblamount" Width="75px" 
                 Runat="server" 
                 text='<%# DataBinder.Eval(Container.DataItem,"ColdWalue") %>'>
            </asp:Label>
        </ItemTemplate>
    </asp:TemplateColumn>
    <asp:TemplateColumn HeaderText="Prospects" 
               HeaderStyle-CssClass="GrdHeaderStyle" 
               ItemStyle-CssClass="GrdItemStyle">
        <ItemTemplate>
        <label class="blackfnt">
    <asp:HyperLink  Runat="server"  Font-Underline="True"  CssClass="blackfnt"  NavigateUrl='<%#"sfm_funnel_report_locwise_2.aspx?calltype=ALL"%>' Text= '<%#DataBinder.Eval(Container.DataItem, "AllKount")%>' ID="Hyperlink1">
    </asp:HyperLink>
    </label>
            <%--<asp:Label ID="lblPayout" Width="75px" Runat="server" 
               text='<%# DataBinder.Eval(Container.DataItem,"AllKount") %>'>
            </asp:Label>--%>
        </ItemTemplate>
    </asp:TemplateColumn>
    <asp:TemplateColumn HeaderText="Value" 
               HeaderStyle-CssClass="GrdHeaderStyle" 
               ItemStyle-CssClass="GrdItemStyle">
        <ItemTemplate>
            <asp:Label ID="lblPayout" Width="75px" Runat="server" 
               text='<%# DataBinder.Eval(Container.DataItem,"AllWalue") %>'>
            </asp:Label>
        </ItemTemplate>
    </asp:TemplateColumn>
    </columns></asp:DataGrid></td></tr>
</table>
                              
                  
                       
                       <%-- <asp:Button ID="btnPrint" runat="server" Text="Print"  Visible="false" style="left: 227px; position: relative; top: 0px"  Width="75px" />
                        <asp:Button ID="btnXLS" runat="server" Text="XLS" Visible="false" style="left: 225px; position: relative; top: 0px"  Width="75px" OnClick="btnXLS_Click" />
                       --%>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnShowReport" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
            </td>
        </tr>
    </table>
                                                    
    </div>
    
</asp:Content>
