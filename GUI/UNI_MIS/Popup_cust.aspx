<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PopUp_Cust.aspx.cs" Inherits="GUI_UNI_Net_MIS_PopUp_Cust" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
   <link id="Link1" href="~/GUI/images/style.css" rel="Stylesheet" type="text/css" runat="server" />
   <script language="javascript">
  
    function Child(obj)
    {
    
    ID="<%=ID%>"
       // alert(ID)
	    var Str = obj.value;
	    var cust_str=""
	   // var cust_str=window.opener.document.aspnetForm.ctl00$MyCPH1$txtCustomer.value;
	    //alert(Str)
	   
	    if(ID=='C')
	    {
	     cust_str=window.opener.document.aspnetForm.ctl00$MyCPH1$txtCustomer.value;
	    }
	    else if(ID=='V')
	    {
	    cust_str=window.opener.document.aspnetForm.ctl00$MyCPH1$txtVendor.value;
	    }
	     else if(ID=='E')
	    {
	    cust_str=window.opener.document.aspnetForm.ctl00$MyCPH1$txtEmployee.value;
	    }
	     else if(ID=='D')
	    {
	    cust_str=window.opener.document.aspnetForm.ctl00$MyCPH1$txtDriver.value;
	    }
	     else if(ID=='A')
	    {
	    cust_str=window.opener.document.aspnetForm.ctl00$MyCPH1$txtAccount.value;
	    }
	    else if(ID=='B')
	    {
	    cust_str=window.opener.document.aspnetForm.ctl00$MyCPH1$txtBank.value;
	    }
	    
	   // alert(cust_str)
	    //window.returnValue = Str;
	   // alert(ID)
	    //window.opener.document.forms[0].csge.value=obj.value
	    if(cust_str=="")
	    {
	         if(ID=='C')
	         {
	             window.opener.document.aspnetForm.ctl00$MyCPH1$txtCustomer.value=Str;
	         }
	         else if(ID=='V')
	        {
	        //cust_str=window.opener.document.aspnetForm.ctl00$MyCPH1$txtVendor.value;
	        window.opener.document.aspnetForm.ctl00$MyCPH1$txtVendor.value=Str;
	        }
	        else if(ID=='E')
	        {
	        //cust_str=window.opener.document.aspnetForm.ctl00$MyCPH1$txtEmployee.value;
	        window.opener.document.aspnetForm.ctl00$MyCPH1$txtEmployee.value=Str;
	        }
	        else if(ID=='D')
	        {
	       // cust_str=window.opener.document.aspnetForm.ctl00$MyCPH1$txtDriver.value;
	        window.opener.document.aspnetForm.ctl00$MyCPH1$txtDriver.value=Str;
	        }
	        else if(ID=='A')
	        {
	       // cust_str=window.opener.document.aspnetForm.ctl00$MyCPH1$txtAccount.value;
	        window.opener.document.aspnetForm.ctl00$MyCPH1$txtAccount.value=Str;
	        }
	        else if(ID=='B')
	        {
	       // cust_str=window.opener.document.aspnetForm.ctl00$MyCPH1$txtAccount.value;
	        window.opener.document.aspnetForm.ctl00$MyCPH1$txtBank.value=Str;
	        }
	         
	    }
	    else 
	    {
	        if(ID=='C')
	         {
	             window.opener.document.aspnetForm.ctl00$MyCPH1$txtCustomer.value=cust_str+','+Str;
	         }
	         else if(ID=='V')
	        {
	              window.opener.document.aspnetForm.ctl00$MyCPH1$txtVendor.value=cust_str+','+Str;
	        }
	        else if(ID=='E')
	        {
	              window.opener.document.aspnetForm.ctl00$MyCPH1$txtEmployee.value=cust_str+','+Str;
	        }
	        else if(ID=='D')
	        {
	              window.opener.document.aspnetForm.ctl00$MyCPH1$txtDriver.value=cust_str+','+Str;
	        }
	        else if(ID=='A')
	        {
	              window.opener.document.aspnetForm.ctl00$MyCPH1$txtAccount.value=cust_str+','+Str;
	        }
	        else if(ID=='B')
	        {
	      window.opener.document.aspnetForm.ctl00$MyCPH1$txtBank.value=cust_str+','+Str;
	       
	        }
	    }
	   // alert(cust_str)
	    //window.opener.document.aspnetForm.ctl00$MyCPH1$txtCustomer.value=Str;
	    //window.opener.document.getElementById('ctl00$MyCPH1$txtCustomer').returnValue = Str;
        window.close(); 
    }

</script>
   <title>Selection Box</title>
</head>
<body>
    <form id="form1" runat="server">
    <p></p><center>

<table border=0 style="width: 6.5in;" align="left" cellspacing=1 cellpadding=0>
<tr><td align="left">
<font class=blackfnt><b><u>Note:</u></b> 
<!--<br>- Please enter Customer Name start with 'S' as 'S'-->
<br>- For All <asp:Label  CssClass="blackfnt" Text=""  runat="server" ID="SelectID"></asp:Label> list,keep blank both the input box.
</font>
</td></tr>
<tr><td align="left">
<br>
            <table border="0" style="width: 5.5in;" cellpadding="1" cellspacing="1" class="boxbg">
  <tr class="bgbluegrey">
     <td colspan=2 align=center><font class=blackfnt>Search by parameter</font></td>
  </tr>
  <tr bgcolor="white" >
   <td><font class=blackfnt><asp:Label  CssClass="blackfnt" Text=""  runat="server" ID="SelectID1"></asp:Label> Code</font></td>
   <td style="text-align: left"><font class=blackfnt>&nbsp;<asp:TextBox ID="txtCustCode" runat="server" CssClass="inp" Width="120px"></asp:TextBox>&nbsp;</font></td>
  </tr>
  <tr bgcolor="white" >
   <td><font class=blackfnt><asp:Label  CssClass="blackfnt" Text=""  runat="server" ID="SelectID2"></asp:Label> Name</font></td>
   <td style="text-align: left"><font class=blackfnt>&nbsp;<asp:TextBox ID="txtCustName" runat="server" CssClass="inp" Width="186px"></asp:TextBox></font></td>
  </tr>
<tr bgcolor="white" >
   <td colspan=2 align=center>
       <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" /></td>
  </tr>
</table>
</td></tr>
<tr><td align="left">
<br>
<table border=0 width=99% cellspacing=1 cellpadding=0>
<tr><td>
<font class=blackfnt><b><u>Note:</u></b> 
<!--<br>- Please enter Customer Name start with 'S' as 'S'-->
<br>- Click on radio buton to select <asp:Label  CssClass="blackfnt" Text=""  runat="server" ID="SelectID3"></asp:Label> .
</font>
</td></tr>
</table>
</td></tr>
<tr><td align="left">
<br />
<table border=0 style="width: 8.5in;" align="left" cellspacing=1 cellpadding=0>
    <tr>
        <td>
            <table border="0" style="width: 5.5in;" cellpadding="1" cellspacing="1" class="boxbg">
                        <tr class="bgbluegrey">
                            <td  width="10"  align="left"></td>
                            <td width="100" nowrap align="left"><font class="blackfnt">&nbsp;<asp:Label  CssClass="blackfnt" Text=""  runat="server" ID="SelectID4"></asp:Label> Code</font></td>
                            <td width="100" nowrap align="left"><font class="blackfnt">&nbsp;<asp:Label  CssClass="blackfnt" Text=""  runat="server" ID="SelectID5"></asp:Label> Name</font></td>
                        </tr>
                    </table>
            <asp:DataList ID="DataList1" runat="server" width="90%">
                
                <ItemTemplate>
                    <table style="width: 5.5in;" border="0" cellpadding="1" cellspacing="1" class="boxbg">
                        <tr>
                            <td width="10%" bgcolor="white" align="left">&nbsp;<input name=chk type=radio onclick="Child(this);" value='<%#DataBinder.Eval(Container.DataItem,"CUSTCD") %>' ></td>
                            <td width="30%" bgcolor="white" align="left"><font class="blackfnt">&nbsp;<%#DataBinder.Eval(Container.DataItem,"CUSTCD") %></font></td>
                            <td bgcolor="white"  align="left"><font class="blackfnt">&nbsp;<%#DataBinder.Eval(Container.DataItem, "CUSTNM")%></font></td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:DataList>
        </td>
    </tr>
</table>
</td></tr>

</table>
<br>
</center><p>
    </form>
</body>
</html>
