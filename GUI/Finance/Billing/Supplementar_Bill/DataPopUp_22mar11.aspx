<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DataPopUp.aspx.cs" Inherits="GUI_Finance_Billing_BillEdit_DataPopUp" %>
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script type="text/javascript" language="javascript">

function radEmpClick(id,ctlid,tbl)
{    
//    
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

function radLocClick(id,ctlid,tbl,tb2)
{    
    //debugger;
        var text=id;
        var idval=text.substring(3,text.length);
//        for(var i=3;i<id.length;i++)
//            {
//                text+=id.charAt(i);
//            }

    lblacctcd=ctlid.replace( "txtAccCode", "lblacctcd");
    if(tbl=='none')
    {
      ctlname=ctlid.replace( "txtAccCode", "txtDescription");
      //   alert(tb2)
        window.opener.document.getElementById(ctlid).value = text;
         window.opener.document.getElementById(ctlname).value = idval;
        //window.opener.document.getElementById(lblacctcd).innerText = text;
        
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
function radAccClick(id,ctlid,tbl,tb2)
{    
    //debugger;
        var text=id;
        var idval=text.substring(3,text.length);
//        for(var i=3;i<id.length;i++)
//            {
//                text+=id.charAt(i);
//            }

    lblacctcd=ctlid.replace( "txtAccCode", "lblacctcd");
    if(tbl=='none')
    {
      ctlname=ctlid.replace( "txtAccCode", "txtDescription");
      //   alert(tb2)
        window.opener.document.getElementById(ctlid).value = text;
         window.opener.document.getElementById(ctlname).value = tb2;
        //window.opener.document.getElementById(lblacctcd).innerText = text;
        
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
   <link id="Link1" href="~/GUI/images/style.css" rel="Stylesheet" type="text/css" runat="server" />

</head>
<body style="font-size: 12pt; font-family: Times New Roman">

    <form id="form1" runat="server">
    <div align="center">
        <table border="0" cellpadding="0" cellspacing="1" width="99%">
            <tr>
                <td>
                    <font class="blackfnt"><b><u>Note:</u></b><strong>
                        <!--<br>- Please enter Customer Name start with 'S' as 'S'-->
                        <br />
                        - For All&nbsp; list,keep blank both the input box. </strong></font>
                </td>
            </tr>
        </table>
        <br />
    <asp:Panel runat="server" ID="divparty" Visible="false">
    <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="85%">
        <tr class="bgbluegrey">
            <td colspan="2" align="center" class="blackfnt">Select Criteria :</td>
        </tr>
    </table>
    <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="85%">   
        <tr bgcolor="#ffffff" id="grouprow" runat="server">
            <td class="blackfnt" align="right">Group</td>
            <td class="blackfnt" align="left">
                <asp:DropDownList ID="cbomaincat" runat="server" CssClass="blackfnt">
                    <asp:ListItem Value="">--Select--</asp:ListItem>
                    <asp:ListItem Value="ASSET">ASSET</asp:ListItem>
                    <asp:ListItem Value="LIABILITY">LIABILITIES</asp:ListItem>
                    <asp:ListItem Value="INCOME">INCOME</asp:ListItem>
                    <asp:ListItem Value="EXPENSES">EXPENSES</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="right">
                <asp:Label ID="lblCode" runat="server"></asp:Label></td>
            <td class="blackfnt" align="left">
                <asp:TextBox runat="server"  ID="txtcustcode"></asp:TextBox>
            </td>
        </tr>
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="right">
                <asp:Label ID="lblName" runat="server"></asp:Label>
            </td>
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
        <br />
        <table border="0" cellpadding="0" cellspacing="1" style="font-size: 12pt; font-family: Times New Roman"
            width="99%">
            <tr>
                <td>
                    <font class="blackfnt"><b><u>Note:</u></b><strong>
                        <!--<br>- Please enter Customer Name start with 'S' as 'S'-->
                        <br />
                        - Click on radio buton to select&nbsp; </strong></font>
                </td>
            </tr>
        </table>
    <br /><br />
        <asp:Table runat="server" BackColor="#808080" ID="tbllist" CellPadding="3" CellSpacing="1" CssClass="boxbg" Width="90%">
        
        </asp:Table>
        
       
    </div>
    
    
    </form>
</body>
</html>
