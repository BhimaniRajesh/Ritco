<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DataPopUp.aspx.cs" Inherits="GUI_Finance_Billing_BillEdit_DataPopUp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<link rel="stylesheet" type="text/css" href="../../../GUI/images/style.css" />
<script type="text/javascript" language="javascript">

function radClick(id,ctlid,tbl,text)
{    
       
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
           if(i<10)
                var id= "ctl00_MyCPH1_" + tbl + "_ctl0" + i + "_" + ctlid;
           else
                var id= "ctl00_MyCPH1_" + tbl + "_ctl" + i + "_" + ctlid;

            window.opener.document.getElementById(id).value = text;
        }
        
    }
          
          window.close();
          return false;
}






function radHeadClick(id,ctlid,tbl,text)
{  
       
        window.opener.document.getElementById("ctl00_MyCPH1_" + ctlid).value = text;
   
    
        var tab=window.opener.document.getElementById("ctl00_MyCPH1_" + tbl);
        if(!tab)
        {
           window.close();
           return false;
        }
        var r=tab.rows.length;
        
        for(var i=2;i<=r;i++)
        {
                // ctl00$MyCPH1$grvcontrols$ctl02$txtpartycode
           if(i<10)
                var id= "ctl00_MyCPH1_" + tbl + "_ctl0" + i + "_txtfrom";
           else
                var id= "ctl00_MyCPH1_" + tbl + "_ctl" + i + "_txtfrom";

            window.opener.document.getElementById(id).value = text;
        }
        
    window.close();
    return false;
}



// THIS FUNCTIN IS USED WHEN GRID HAS 4 HEADER ROWS

function rad4RowClick(id,ctlid,tbl,text)
{    
       

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
                var id= "ctl00_MyCPH1_" + tbl + "_ctl0" + i + "_" + ctlid;
           else
                var id= "ctl00_MyCPH1_" + tbl + "_ctl" + i + "_" + ctlid;

            window.opener.document.getElementById(id).value = text;
        }
        
    }
          
          window.close();
          return false;
}



// THIS FUNCTIN IS USED WHEN GRID HAS 4 HEADER ROWS
function rad4HeadClick(id,ctlid,tbl,text)
{  

   
        window.opener.document.getElementById(ctlid).value = text;
   
    
        var tab=window.opener.document.getElementById("ctl00_MyCPH1_" + tbl);
        var r=tab.rows.length;
        
        for(var i=2;i<=r;i++)
        {
                // ctl00$MyCPH1$grvcontrols$ctl02$txtpartycode
           if(i<10)
                var id= "ctl00_MyCPH1_" + tbl + "_ctl0" + i + "_txtfrom";
           else
                var id= "ctl00_MyCPH1_" + tbl + "_ctl" + i + "_txtfrom";

            window.opener.document.getElementById(id).value = text;
        }
        
    window.close();
    return false;
}

</script>

    <title>Untitled Page</title>
   <link type="text/css" href="../../images/style.css" />
</head>
<body>

    <form id="form1" runat="server">
    <br />
    <asp:Panel runat="server"  Width="8in">
    <asp:Table runat="server" Width="100%">
    <asp:TableRow>
    </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell>
                 <asp:Panel ID="divcriteria" runat="server">
                    <asp:Table runat="server" CssClass="boxbg" CellSpacing="1" BorderWidth="0" Width="100%">
                        <asp:TableRow BackColor="White">
                            <asp:TableCell>
                                <asp:Label ID="lblcodename" runat="server" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox ID="txtlocation" runat="server" BorderStyle="groove" Width="100px"></asp:TextBox>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow BackColor="White" ID="trlocname" runat="server">
                            <asp:TableCell>
                                <asp:Label ID="lblname" runat="server" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox ID="txtlocationname" runat="server" BorderStyle="groove" Width="100px"></asp:TextBox>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="bgbluegrey">
                               <asp:TableCell ColumnSpan="2" HorizontalAlign="Center">
                                <asp:Button ID="btnsubmit" OnClick="btnsubmit_Click" Text="Submit" runat="server" CssClass="blackfnt" />
                               </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                 </asp:Panel>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell>
                   <asp:Table runat="server" ID="tbllist" CellPadding="3" CellSpacing="1" BackColor="#8ba0e5" CssClass="boxbg" Width="100%">
        </asp:Table>
            </asp:TableCell>
        </asp:TableRow>
    </asp:Table>
   
    
      
    </asp:Panel>
   
      
        
       
   
    
    </form>
</body>
</html>
