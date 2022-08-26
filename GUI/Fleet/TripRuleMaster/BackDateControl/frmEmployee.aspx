<%@ Page Language="C#" AutoEventWireup="true" CodeFile="frmEmployee.aspx.cs" Inherits="GUI_WebAdmin_popup_cust" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
   <link id="Link1" href="~/GUI/images/style.css" rel="Stylesheet" type="text/css" runat="server" />
   <script language="javascript">
    var Str="";
    function Child(obj)
    {
        Str="";
        var hdnid = document.getElementById("hdnid");
        
        if(document.form1.chk.length == 1)
        {
            if(document.form1.chk.checked){Str=document.form1.chk.value;}
        } 
        else 
        {
            for(i=0;i<document.form1.chk.length;i++)
            {
                if(document.form1.chk[i].checked)
                {
                    if(Str=="")
                    {
                        Str=document.form1.chk[i].value
                    } 
                    else 
                    {
                        Str = Str+ "," + document.form1.chk[i].value
                    }
                }
            }
            
        }
        if(Str == "")
        {
            if(document.form1.chk.checked)
            {
                Str = document.form1.chk.value;
            }
        }
	    //window.opener.document.aspnetForm.hdnid.value=Str;
	    
	    var txtempcd = window.opener.document.getElementById(hdnid.value);
	    txtempcd.value = Str;
	    
    }
    function Checkall(obj)
    {  
        Str="";
        var hdnid = document.getElementById("hdnid");
        
        var Hdnidvalue = hdnid.value;
        
        
        if(document.form1.chkall.checked == true)
        {
            for(i=0;i<document.form1.chk.length;i++)
            {      
                document.form1.chk[i].checked = true
                Str = Str+ "," + document.form1.chk[i].value
            }
        }
        else
        {
            for(i=0;i<document.form1.chk.length;i++)
            {      
                document.form1.chk[i].checked = false
            }
        }
        if(Str == "")
        {
            if(document.form1.chk.checked)
            {
                Str = document.form1.chk.value;
            }
        }
	    var txtempcd = window.opener.document.getElementById(hdnid.value);
	    txtempcd.value = Str;
	    //window.opener.document.aspnetForm.Hdnidvalue.value=Str;
    }
</script>
   <title>Employee</title>
</head>

<body>
    <form id="form1" runat="server">
    <p></p><center>
<table border=0 width=99% cellspacing=1 cellpadding=0>
<tr><td>
<font class=blackfnt><b><u>Note:</u></b> 
<!--<br>- Please enter Customer Name start with 'S' as 'S'-->
<br>- For All Employee list,keep blank both the input box.
</font>
</td></tr>
</table>
<br>
<table border=1 width=85% cellspacing=1 cellpadding=2>
  <tr class="bgbluegrey">
     <td colspan=2 align=center><font class=blackfnt>Search by parameter</font></td>
  </tr>
  <tr>
   <td><font class=blackfnt>Employee Code</font></td>
   <td style="text-align: left"><font class=blackfnt>&nbsp;<asp:TextBox ID="txtEmpCode" runat="server" CssClass="inp" Width="120px"></asp:TextBox>&nbsp;</font></td>
  </tr>
  <tr>
   <td><font class=blackfnt>Employee Name</font></td>
   <td style="text-align: left"><font class=blackfnt>&nbsp;<asp:TextBox ID="txtEmpName" runat="server" CssClass="inp" Width="186px"></asp:TextBox></font></td>
  </tr>
<tr>
   <td colspan=2 align=center>
       <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" /></td>
  </tr>
</table>
<br>
<table border=0 width=99% cellspacing=1 cellpadding=0>
<tr><td>
<font class=blackfnt><b><u>Note:</u></b> 

<br>- Click on Check box to select Employee.
</font>
</td></tr>
</table>
<br />
<table border=0 width=100% cellspacing=1 cellpadding=0>
    <tr>
        <td>
            <table border="0" width="90%" cellpadding="1" cellspacing="1" class="boxbg">
                        <tr class="bgbluegrey">
                            <td width="10%" align="center">
                                <%--<input name="chkall" type="checkbox" onclick="Checkall(this);" value='ALL' >--%>
                            </td>
                            <td width="30%" align="left"><font class="blackfnt">&nbsp;Employee Code</font></td>
                            <td align="left"><font class="blackfnt">&nbsp;Employee Name</font></td>
                        </tr>
                    </table>
            <asp:DataList ID="DataList1" runat="server" width="90%">
                
                <ItemTemplate>
                    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="boxbg">
                        <tr>
                            <td width="10%" bgcolor="white" align="left">&nbsp;<input name="chk" type="checkbox" onclick="Child(this);" value='<%#DataBinder.Eval(Container.DataItem,"userid") %>' ></td>
                            <td width="30%" bgcolor="white" align="left"><font class="blackfnt">&nbsp;<%#DataBinder.Eval(Container.DataItem, "userid")%></font></td>
                            <td bgcolor="white" align="left"><font class="blackfnt">&nbsp;<%#DataBinder.Eval(Container.DataItem, "name")%></font></td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:DataList>
            <asp:HiddenField ID="hdnid" runat="server" />
        </td>
    </tr>
</table>
<br>
</center><p>
    </form>
</body>
</html>
