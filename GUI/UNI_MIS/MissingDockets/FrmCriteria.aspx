<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="FrmCriteria.aspx.cs" Inherits="FrmCriteria" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">
    
    function BranchPopup(strPopupURL)
            {
                var strWinFeature = "height=280,width=350,resizable=yes,scrollbars=yes,left=420,top=5"
                
                winNew = window.open(strPopupURL, "_blank", strWinFeature)
            }
    </script>

    <br />
    <%--<asp:Label ID="Label1" Font-Underline="True" Font-Bold ="True" runat="server" Text="Reports/Operations/Missing Dockets Query"></asp:Label>--%>
    <table style="width: 1000px">
        <tr>
            <td align="left">
                <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                    <b>Reports</b></font></a> <b>&gt; </b><a href="../rpt_Operation.aspx"><font class="blklnkund">
                        <b>Operations</b></font></a> <b>&gt; </b><font class="bluefnt"><b><%=Session["DocketCalledAs"] %> Not Used</b></font>
            </td>
            <td align="right">
                <a href="javascript:window.history.go(-1)" title="back">
                    <img src="../../images/back.gif" border="0" alt="" /></a>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <br />
    <div align="left">
        <table style="width: 715px; height: 173px;" border="0" cellpadding="0" cellspacing="1"
            class="boxbg">
            <tr bgcolor="white" class="bgbluegrey">
                <td align="center" colspan="4" class="blackfnt" style="height: 23px">
                    Select To Pay Arrival Criteria
                </td>
            </tr>
            <tr bgcolor="white">
                <td class="blackfnt" valign="top" align="left" style="width: 144px">
                    Select Date</td>
                <td class="blackfnt" align="left" valign="top" style="width: 208px">
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server"      UpdateMode="Conditional" RenderMode="Inline">
                        <ContentTemplate>
                            <asp:RadioButtonList ID="radDate" runat="server" AutoPostBack="true" CssClass="blackfnt"
                                ValidationGroup="VGDtFromTo" OnSelectedIndexChanged="radDate_SelectedIndexChanged">
                                <asp:ListItem Selected="false" Text=" Series Allocated From[dd/mm/yyyy]" Value="0"></asp:ListItem>
                                <asp:ListItem Selected="false" Text=" Series Allocated Last Week (Including Today)"
                                    Value="1"></asp:ListItem>
                                <asp:ListItem Selected="true" Text="Series Allocated Today" Value="2"></asp:ListItem>
                            </asp:RadioButtonList>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
                <td align="left" class="blackfnt" colspan="2" valign="top">
                    <asp:UpdatePanel ID="UpdatePanel4" runat="server"     UpdateMode="Conditional" RenderMode="Inline">
                        <ContentTemplate>
                            <asp:TextBox ID="txtDateFrom" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                            <asp:TextBox ID="txtDateTo" runat="Server" Width="80"></asp:TextBox>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="radDate" EventName="SelectedIndexChanged" />
                        </Triggers>
                    </asp:UpdatePanel>
                    <div align="left">
                        <asp:CustomValidator ID="CustomValidator2" runat="server" ErrorMessage="Date Range can not be greater than 1 month "
                            OnServerValidate="daterange" Width="355px"></asp:CustomValidator>
                        <asp:CustomValidator ID="CustomValidator1" runat="server" OnServerValidate="abc"
                            ErrorMessage="To date can not be smaller than from date " Width="255px"></asp:CustomValidator></div>
                </td>
            </tr>
            <tr runat="server" bgcolor="white">
                <td align="left" class="blackfnt" style="width: 144px">
                    Series Allocation Completed</td>
                <td align="left" class="blackfnt" colspan="3">
                    <asp:UpdatePanel ID="UpdatePanel5" runat="server"    UpdateMode="Conditional" RenderMode="Inline">
                        <ContentTemplate>
                            <asp:DropDownList ID="CmbSeriesAllocate" runat="server" Width="206px">
                                <asp:ListItem Value="">Dont Care</asp:ListItem>
                                <asp:ListItem Value="Y">Yes</asp:ListItem>
                                <asp:ListItem Value="N">No</asp:ListItem>
                            </asp:DropDownList>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr id="trro" runat="server" bgcolor="white">
                <td align="left" class="blackfnt" style="width: 144px">
                    Select RO</td>
                <td colspan="3" class="blackfnt" align="left">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server"   UpdateMode="Conditional" RenderMode="Inline">
                        <ContentTemplate>
                            <asp:DropDownList ID="CmbRO" runat="server" OnSelectedIndexChanged="CmbRO_SelectedIndexChanged"
                                Width="206px" AutoPostBack="True">
                            </asp:DropDownList></ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr bgcolor="white">
                <td align="left" class="blackfnt">
                    Select Allocated To</td>
                <td colspan="3" align="left">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server"  UpdateMode="Conditional" RenderMode="Inline">
                        <ContentTemplate>
                            <asp:DropDownList ID="CmbLoc" runat="server" Width="153px">
                            </asp:DropDownList>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="CmbRO" EventName="SelectedIndexChanged" />
                        </Triggers>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr bgcolor="white">
                <td align="left" class="blackfnt" style="width: 144px">
                    Series Containing :</td>
                <td align="left" class="blackfnt" colspan="3">
                    <asp:TextBox CssClass="blackfnt" ID="TxtCNote" runat="server"></asp:TextBox>
                    CNote</td>
            </tr>
        </table>
    </div>
    <br />
    <br />
    <div align="center" style="width: 715px">
        <asp:Button ID="BtnSubmit" runat="server" OnClick="BtnSubmit_Click" Text="Show Series"
            ForeColor="Black" Width="87px" /><br />
    </div>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
        ShowSummary="False" />
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtDateFrom"
        ErrorMessage="From Date Can Not Be Blank" ForeColor="White"></asp:RequiredFieldValidator>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtDateTo"
        ErrorMessage="To Date Can Not Be Blank" ForeColor="White"></asp:RequiredFieldValidator>
    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtDateTo"
        ErrorMessage="Please Enter Valid To Date" ForeColor="White" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
        Width="168px"></asp:RegularExpressionValidator>
    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtDateFrom"
        ErrorMessage="Please Enter Valid From Date" ForeColor="White" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
        Width="168px"></asp:RegularExpressionValidator>
    &nbsp;<br />
    &nbsp;
</asp:Content>
