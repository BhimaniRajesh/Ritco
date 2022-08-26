<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DataPopUp.aspx.cs" Inherits="GUI_Finance_Billing_BillEdit_DataPopUp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script type="text/javascript" language="javascript">

function radClick(id,ctlid,tbl)
{    
        var text="";
        for(var i=3;i<id.length;i++)
            {
                text+=id.charAt(i);
            }
    if(tbl=='none')
    {
       
        window.opener.document.getElementById(ctlid).value = text;
    }
    else 
    {
    
        var tab=window.opener.document.getElementById("ctl00_MyCPH1_" + tbl);
        var r=tab.rows.length;
        
        for(var i=2;i<=r;i++)
        {
                // ctl00$MyCPH1$grvcontrols$ctl02$txtpartycode
           if(i<10)
                var id="ctl00_MyCPH1_grvcontrols_ctl0" + i + "_" + ctlid;
           else
                var id="ctl00_MyCPH1_grvcontrols_ctl" + i + "_" + ctlid;

            window.opener.document.getElementById(id).value = text;
        }
        
    }
          
          window.close();
}

</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
    <link href="../../../images/style.css" rel="stylesheet" type="text/css" />
</head>
<body>

    <form id="form1" runat="server">
    <div align="center">
    <br /><br />
    <asp:Panel runat="server" ID="divparty" Visible="false">
    <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="85%">
        <tr class="bgbluegrey">
            <td colspan="2" align="center" class="blackfnt">Select Criteria :</td>
        </tr>
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="right">Customer Code : </td>
            <td class="blackfnt" align="left">
                <asp:TextBox runat="server" ID="txtcustcode"></asp:TextBox>
            </td>
        </tr>
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="right">Customer Name : </td>
            <td class="blackfnt" align="left">
                <asp:TextBox runat="server" ID="txtcustname"></asp:TextBox>
            </td>
        </tr>
        <tr bgcolor="#ffffff">
            <td colspan="2" align="center" class="blackfnt"> 
                <asp:Button  runat="server" Text="Submit" OnClick="btnpartysubmit_Click" ID="Button1"/>
            </td>
        </tr>
    </table>
    
      
    </asp:Panel>
    <br /><br />
        <asp:Table runat="server" BackColor="#808080" ID="tbllist" CellPadding="3" CellSpacing="1" CssClass="boxbg" Width="90%">
        
        </asp:Table>
        
       
    </div>
    
    
    </form>
</body>
</html>
