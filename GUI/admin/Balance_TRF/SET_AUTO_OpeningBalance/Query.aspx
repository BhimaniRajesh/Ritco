<%@ Page Language="C#" AutoEventWireup="true"     MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="Query.aspx.cs" Inherits="GUI_UNI_MIS_Account_Reports_TrailBalance_ver3_Query" %>

<%@ Register TagName="LH" TagPrefix="Location" Src="~/GUI/UNI_MIS/LocationHirarchy.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

 

    <script language="JavaScript" type="text/javascript">
    
        function Check_Submit_Data()
        {
            if(document.getElementById('ctl00$MyCPH1$RD_CUST_VEND').value=="")
            {
                alert("Plz Select Vendor/Customer.")
                document.getElementById('ctl00$MyCPH1$RD_CUST_VEND').focus();
                return false;
            }
            if(document.getElementById('ctl00$MyCPH1$LT_ACC').value=="")
            {
                alert("Plz Select A Single Ledger")
                document.getElementById('ctl00$MyCPH1$LT_ACC').focus();
                return false;
            }
            
        }
        function nwOpen(mNo)
        {
           
            window.open("../setting_cust_opn_bal/popupbranch.aspx?mNo=" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
    </script>

    <div align="left">
        <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                        class="blklnkund"><strong>Report </strong></font><font class="bluefnt"><strong><font
                            class="blklnkund"><strong>Finance </strong></font><font class="bluefnt"><strong>&gt;
                            </strong><strong>Trail Balance Report</strong> </font>
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="../../../images/clear.gif" width="2" height="1" /></td>
            </tr>
            <tr>
                <td align="right">
                    <div align="center">
                        <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                            <ProgressTemplate>
                                <div id="progressArea">
                                  <%-- <ProgressTemplate>--%>
                                        <asp:Table ID="Table1" runat="server">
                                        <asp:TableRow>
                                        <asp:TableCell><asp:Image ID="imgwaiting" runat="server" ImageUrl="~/GUI/images/loading.gif" /></asp:TableCell>
                                        <asp:TableCell CssClass="blackfnt" Font-Bold="true">&nbsp; Please Wait</asp:TableCell>
                                        </asp:TableRow>
                                        </asp:Table>
                                     <%--   </ProgressTemplate>                --%>               
                                         </div>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </div>
                   <%-- <a href="javascript:window.history.go(-1)" title="back">
                        <img alt="Back" src="../../../images/back.gif" border="0" />
                    </a>--%>
                </td>
            </tr>
            <tr>
                <td  valign="top">
                    <table cellspacing="1" style="width: 8.0in" class="boxbg" align="left">
                        <tr class="bgbluegrey">
                            <td align="center" colspan="3">
                                <font class="blackfnt"><b>Select   Criteria</b></font>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left" colspan="1">
                                  <font class="blackfnt"><b>Select Location</b></font>
                            </td>
                             <td align="left" colspan="2">
                               <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                    <ContentTemplate>
                                <asp:TextBox ID="txtBranchCode"     CssClass="blackfnt" runat="server" Width="100px"  AutoPostBack="true" OnChange="Javascript:this.value=this.value.toUpperCase();" OnTextChanged="RD_CUST_VEND_SelectedIndexChanged"></asp:TextBox>
                            
                                 <input id="BTN_locpop" onclick="nwOpen(1);" type="button" value="..." name="Locpup12" runat="server" />
                                   </ContentTemplate>  </asp:UpdatePanel> 
                            </td>
                        </tr>
                        <%--<tr style="background-color: white">
                            <td align="center">
                                <font class="blackfnt">Select Voucher Date</font>
                            </td>
                            <td align="left" colspan="2">
                                <Date:DT ID="DT" runat="server" />
                            </td>
                        </tr>--%>
                        <tr id="Tr1" visible="false" runat="server" style="background-color: white">
                            <td align="left">
                                <asp:Label ID="Label12" CssClass="blackfnt" Text="Select Account" runat="server" ></asp:Label></td>
                            <td align="left" colspan="2" valign="top">
                                <asp:DropDownList ID="DLLAcc" runat="server">
                                </asp:DropDownList>
                            </td>
                        </tr>
                       <%-- <tr align="center" bgcolor="white">
                            <td colspan="3">
                                <asp:RadioButtonList ID="rpttyp" RepeatDirection="horizontal" CssClass="blackfnt"
                                    runat="server">
                                    <asp:ListItem Text="Group Wise" Selected Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Location Wise" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="Customer Wise" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="Vendor Wise" Value="4"></asp:ListItem>
                                    <asp:ListItem Text="Employee Wise" Value="5"></asp:ListItem>
                                    <asp:ListItem Text="Driver Wise" Value="7"></asp:ListItem>
                                    <asp:ListItem Text="Account Wise" Value="6"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>--%>
                       <%-- <tr align="center" bgcolor="white">
                            <td colspan="3">
                                <asp:RadioButtonList ID="rpttyp_SUB" RepeatDirection="horizontal" CssClass="blackfnt"
                                    runat="server">
                                    <asp:ListItem Text="Ledger Wise" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Location Wise" Value="2"></asp:ListItem>
                                </asp:RadioButtonList></td>
                        </tr>--%>
                        <tr align="center" bgcolor="white">
                            <td align="center">
                                <asp:Label ID="Label1" CssClass="blackfnt" Text="Select " runat="server"></asp:Label>
                                <asp:UpdatePanel ID="UP1" runat="server">
                                    <ContentTemplate>
                                       <%-- <asp:RadioButtonList ID="RD_CUST_VEND" RepeatDirection="horizontal" CssClass="blackfnt" 
                                            runat="server" OnSelectedIndexChanged="RD_CUST_VEND_SelectedIndexChanged" AutoPostBack="true">
                                            <asp:ListItem Text="Customer" Selected="True" Value="3"></asp:ListItem>
                                            <asp:ListItem Text="Vendor" Value="4"></asp:ListItem>
                                            <asp:ListItem Text="Employee" Value="5" Enabled="false"></asp:ListItem>
                                            <asp:ListItem Text="Driver" Value="6" Enabled="false"></asp:ListItem>
                                        </asp:RadioButtonList>--%>
                                        <asp:DropDownList ID="RD_CUST_VEND" CssClass="blackfnt" runat="server" OnSelectedIndexChanged="RD_CUST_VEND_SelectedIndexChanged" AutoPostBack="true">
                                            <asp:ListItem Text="Select"   Selected="True" Value=""></asp:ListItem>
                                            <asp:ListItem Text="Customer"   Value="3"></asp:ListItem>
                                            <asp:ListItem Text="Vendor" Value="4"></asp:ListItem>
                                            <asp:ListItem Text="Employee" Value="5"  ></asp:ListItem>
                                            <asp:ListItem Text="Driver" Value="6"  Enabled ="false"  ></asp:ListItem> 
                                        </asp:DropDownList>
                                        </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                            <td colspan="2" align="Left">
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                    <ContentTemplate>
                                        <asp:ListBox ID="LT_CUST_VEND" Width="500" Height="150" SelectionMode="multiple" runat="server" CssClass="blackfnt">
                                        </asp:ListBox>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                <%--<asp:ListItem Text="All" Value="All" Selected="True">
                                </asp:ListItem>--%>
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td align="left">
                                <asp:Label ID="Label2" CssClass="blackfnt" Text="Select Account" runat="server"></asp:Label></td>
                            <td colspan="2" align="Left">
                                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                    <ContentTemplate>
                                        <asp:ListBox ID="LT_CAT" Width="150" Height="80" SelectionMode="Multiple" runat="server"
                                            OnSelectedIndexChanged="LT_CAT_SelectedIndexChanged" AutoPostBack="true" CssClass="blackfnt">
                                        </asp:ListBox>
                                        <asp:ListBox ID="LT_ACC" Width="400" Height="100" SelectionMode="Single" runat="server"
                                            CssClass="blackfnt">
                                            <asp:ListItem Text="All" Value="All" Selected="True"></asp:ListItem>
                                        </asp:ListBox>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td colspan="3">
                                <asp:RadioButtonList ID="rptmd" RepeatDirection="horizontal" CssClass="blackfnt"
                                    runat="server">
                                    <asp:ListItem Text="HTML Format" Selected="true" Value="N"></asp:ListItem>
                                    <asp:ListItem Text="XLS Format" Value="Y"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td colspan="3">
                                <asp:Button ID="btnShow"  OnClick="btnShow_Click" runat="server" Text="Show" Width="75px" />
                                <%--OnClientClick="Javascript: return DateCheck();"--%>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
