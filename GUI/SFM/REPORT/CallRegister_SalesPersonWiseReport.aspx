<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="CallRegister_SalesPersonWiseReport.aspx.cs" Inherits="REPORT_CallRegister_SalesPersonWiseReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript">

function datecheck(txtDateFrom,txtDateTo)
{
    if(txtDateFrom.value == "" || txtDateTo.value == "")
    {
    alert("Please Enter Date")
    return false
    }
}

</script>
<table style="width: 100%">

        <tr>
            <td align="left"  colspan="3">
            <font class="blackfnt"><%=callvisit%> Register-Sales Person Wise Report</font>
                <%--<asp:Label ID="lblWelcome" runat="server" Text="Visit Register-Sales Person Wise Report" CssClass="blackfnt" Font-Bold="true"></asp:Label>--%>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
        </table>
        <br />


    <div align="center">
        <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" colspan="2" width="71%">
    
                                                    <tr bgcolor="#ffffff" style="font-weight: bold; font-size: 12pt; font-family: Times New Roman">
                                                        <td align="left">
                                                            <font class="blackfnt">Employee Name</font></td>
                                                        <td valign="top" align ="left" colspan="2">
                                                            <asp:TextBox ID="txtEmpCode" runat="server" CssClass="blackfnt"></asp:TextBox>&nbsp;
                                                            <input id="btnCust" type="button" name="" runat="server"/>
                                                           <%--<atlas:AutoCompleteExtender runat="server" ID="Extender1" >
              <atlas:AutoCompleteProperties Enabled="True"
            TargetControlID="txtEmpCode"
            ServiceMethod="GetBlogEmpTitlesForAutoComplete"
            ServicePath="~/Service/AutoCompleteSFM.asmx" MinimumPrefixLength="1"    />
            </atlas:AutoCompleteExtender>--%>
                                                            <%--<asp:Button ID="btnPopUp" runat="server" Text="..." Width="26px"/>--%>
                                                            </td>
                                                    </tr>
             <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                                        <td valign="top" align ="left" >
                                                            <font class="blackfnt">Select Call Date </font>
                                                        </td>
                                                        <td style="font-size: 12pt; font-family: Times New Roman" valign="top" align="left">
                                                            <asp:UpdatePanel ID="UpdatePanel3"    UpdateMode="Conditional" RenderMode="Inline" runat="server">
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
                            <asp:UpdatePanel ID="UpdatePanel4" RenderMode="Inline"   UpdateMode="Conditional" runat="server">
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
                                                    
                                                    
                                                    
                                                </table>
                                                <br />
                                                <table  border="0" cellpadding="3" cellspacing="1" width="71%">
                                                    <tr >
                                                        <td align ="center" colspan="3">
                                                        
                                                        <asp:Button ID="btnShowReport" runat="server" Text="Show Report" Width="96px" OnClick="btnShowReport_Click" />
                                                        
                                                        </td>
                                                        
                                                    </tr>
                                                    </table>
                                                    
                                                    <table cellspacing="1" style="width: 100%">
        <tr align="center">
            <td align="center">
                <asp:UpdatePanel ID="u1"  UpdateMode="Conditional" runat="server">
                    <ContentTemplate>
                        
                         
                  <asp:DataGrid ID="dgCallReg" runat="server" BorderWidth="1" CellSpacing="1" CellPadding="5"  HeaderStyle-Font-Bold="true" HeaderStyle-CssClass="bgbluegrey" BorderColor="#8ba0e5" AllowPaging="true" CssClass="blackfnt">
                                
                  </asp:DataGrid>
                       
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
