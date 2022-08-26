<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="List_ESI.aspx.cs" Inherits="GUI_admin_CustomerMaster_ListAll" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="JavaScript" type="text/javascript">
  function ValidateData()
            {
             if(document.getElementById("ctl00_MyCPH1_ddlpfcd"))
                {
               // alert(document.getElementById("ctl00_MyCPH1_ddlpfcd").value);
                    if(document.getElementById("ctl00_MyCPH1_ddlpfcd").value == "Select")
                    {
                        alert("Select ESI Code ");
                        document.getElementById("ctl00_MyCPH1_ddlpfcd").focus();
                        return false;
                    }
              }
          }

    </script>

    <div style="width: 10in">
        <br />
        
        <table border="0" align="left" cellpadding="0" cellspacing="0" style="width: 100%;">
            <tr>
                <td align="left">
                    <a><font class="blklnkund"><b>HR & Payroll</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                        <b>Masters</b></font></a> <b>&gt; </b><font class="bluefnt"><b>ESI Master</b></font>
                </td>
            </tr>
        </table>
        <%--<tr> 
          <td><img src="../../images/clear.gif" width="15" height="10" alt="" /></td>
        </tr>--%>
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
       
        <table border="0" cellspacing="1" cellpadding="3" width="30%" align="center" class="boxbg">
            <tr bgcolor="#FFFFFF">
                <td align="center" colspan="2">
                    <font class="blackfnt"><b>ESI Master Edit &nbsp;</b></font></td>
            </tr>
            <tr bgcolor="#FFFFFF">
                <td>
                    <font class="blackfnt"><b>Select ESI Code : &nbsp;</b></font></td>
                <td>
                    <asp:DropDownList ID="ddlpfcd" runat="server">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr bgcolor="#FFFFFF">
                <td align="center" colspan="2">
                    <asp:Button ID="btnsubmit" Text="Submit" OnClick="submit" runat="server" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
