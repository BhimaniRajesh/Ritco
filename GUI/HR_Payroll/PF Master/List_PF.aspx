<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="List_PF.aspx.cs" Inherits="GUI_admin_CustomerMaster_ListAll" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
<script language="JavaScript" type="text/javascript">
  function ValidateData()
            {
             if(document.getElementById("ctl00_MyCPH1_ddlpfcd"))
                {
                    if(document.getElementById("ctl00_MyCPH1_ddlpfcd").value == "Select")
                    {
                        alert("Select PF Code ");
                        document.getElementById("ctl00_MyCPH1_ddlpfcd").focus();
                        return false;
                    }
              }
          }

</script>
  
    <div style="width: 10in">
    <br />
        <br />
        <br />
        
        <table border="0" align="left"  cellpadding="0" cellspacing="0" style="width: 100%;">
           
            <tr>
               <td align="left">
                <a><font class="blklnkund"><b>HR & Payroll</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                    <b>Masters</b></font></a> <b>&gt; </b><font class="bluefnt"><b>PF Master</b></font>
            </td>
            </tr>
        </table>
        <%--<tr> 
          <td><img src="../../images/clear.gif" width="15" height="10" alt="" /></td>
        </tr>--%>
        <br />
        
        <br />
        <br />   <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <table border="0" cellspacing="1" cellpadding="3" width="30%" align="center" class="boxbg">
         <tr bgcolor="#FFFFFF">
                <td align="center" colspan="2">
                    <font class="blackfnt"><b> PF Master Edit &nbsp;</b></font></td>
         </tr>
            <tr bgcolor="#FFFFFF">
                <td>
                    <font class="blackfnt"><b> Select PF Code : &nbsp;</b></font></td>
            
                <td>
                    <asp:DropDownList ID="ddlpfcd" runat="server">
                    </asp:DropDownList>
                </td>
            </tr>
             <tr bgcolor="#FFFFFF">
                <td align="center" colspan="2">
                   <asp:Button id="btnsubmit" Text="Submit" OnClick="submit" runat="server" />
                    </td>
         </tr>
        </table>
    </div>
</asp:Content>
