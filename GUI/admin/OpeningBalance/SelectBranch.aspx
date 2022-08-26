<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="SelectBranch.aspx.cs" Inherits="GUI_admin_OpeningBalance_SelectBranch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">

        function nwOpen(mNo)
                {
                    var FrmChild = window.open('popupbranch.aspx?' + mNo,'myWindow','height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15'); 
                    if(FrmChild != null)
                    {

                    }
                    else
                    {
                        return false;
                    }
                }

        function fsubmit(txtBranchCode) {

            var hdnerror = document.getElementById("ctl00_MyCPH1_hdnerror");
        var txtbrcd=document.getElementById("ctl00_MyCPH1_txtBranchCode");
            // alert(txtbrcd.value);
            if (txtbrcd.value=="")
            {
                alert("Please enter the 'Branch Code'")
                txtbrcd.focus();
                return false;
            }
            if (hdnerror.value == "Y") {
                alert("Please enter the valid 'Branch Code'")
                txtbrcd.focus();
                return false;
            }
        }	
        function value(obj)
        {
            alert(obj.name);
        }
    </script>

    <br />
    <br />

    <table cellspacing="1" cellpadding="5" align="left" border="0" class="boxbg">
     <tr  class="bgbluegrey">
      <td colspan="2" align="center">
                <font class="blackfnt"><b>Set Opening Balance For ASSET/LIABILITY Ledgers</b></font>
            </td>
     </tr>
        <tr bgcolor="#FFFFFF">
            <td>
                <font class="blackfnt">Enter Branch Code</font>
            </td>
            <td>
                <asp:UpdatePanel ID="up1" RenderMode="Inline"    UpdateMode="Always" runat="server">
                    <ContentTemplate>
                        <asp:TextBox ID="txtBranchCode" BorderStyle="Groove" CssClass="blackfnt" runat="server" Width="109px" OnChange="Javascript:this.value=this.value.toUpperCase();" AutoPostBack="true" OnTextChanged="text_change"></asp:TextBox>        
                        <asp:Label ID="error" runat="server" CssClass="redfnt"></asp:Label>
                        <asp:HiddenField ID="hdnerror" runat="server"></asp:HiddenField>
                    </ContentTemplate>
                </asp:UpdatePanel>
                
                <input type="button" onclick="nwOpen(1);" Value="..." style="width: 18px; height: 21px" size="" />&nbsp;
            </td>
        </tr>
         <tr bgcolor="#ffffff">
            <td>
                <font class="blackfnt">Select Account Category</font></td>
            <td>
                <asp:UpdatePanel ID="updatepanel1" runat="server">
                    <ContentTemplate>
                        <asp:DropDownList ID="DDLACC_CAT" AutoPostBack="true" runat="server" CssClass="blackfnt" OnSelectedIndexChanged="DDLACC_CAT_SelectedIndexChanged" >
                            <%--<asp:ListItem Text="All" Value="All"></asp:ListItem>--%>
                            <asp:ListItem Text="ASSET" Selected="True" Value="ASSET"></asp:ListItem>
                            <asp:ListItem Text="LIABILITY" Value="LIABILITY"></asp:ListItem>
                            <%--<asp:ListItem Text="EXPENSES" Value="EXPENSES"></asp:ListItem>
                            <asp:ListItem Text="INCOME" Value="INCOME"></asp:ListItem>
                            <asp:ListItem Text="BANK" Value="BANK"></asp:ListItem>
                            <asp:ListItem Text="CASH" Value="CASH"></asp:ListItem>--%>
                        </asp:DropDownList>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr bgcolor="#ffffff">
            <td><font class="blackfnt">
                Enter Account Code </font></td>
            <td>
                <asp:UpdatePanel ID="updatepanel8" runat="server">
                    <ContentTemplate>
                        <asp:DropDownList ID="dlstAcccode" runat="server" CssClass="blackfnt">
                        </asp:DropDownList>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="DDLACC_CAT" EventName="SelectedIndexChanged" />
                    </Triggers>
                </asp:UpdatePanel>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td colspan="2" align="center">
                &nbsp;<asp:Button ID="btnSubmit" runat="server" Text="Submit"  CssClass="blackfnt" OnClick="btnSubmit_Click"  OnClientClick="Javascript: return fsubmit();"/></td>
        </tr>
    </table>
</asp:Content>
