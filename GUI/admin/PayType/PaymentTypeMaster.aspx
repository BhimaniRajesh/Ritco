<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="PaymentTypeMaster.aspx.cs" Inherits="GUI_Octroi_ViewnPrint_TypeMast" %>


<asp:Content ContentPlaceHolderID="MyCPH1" ID="aaaa" runat="server">

<script type="text/javascript" language="javascript">
function resetFields()
{
      document.getElementById("ctl00$MyCPH1$txtpaytypecode").value="";
      document.getElementById("ctl00$MyCPH1$txtshortdesc").value="";
      document.getElementById("ctl00$MyCPH1$txtdetdesc").value="";
      document.getElementById("ctl00$MyCPH1$chkflag").checked=true;
      document.getElementById("ctl00$MyCPH1$txtflag").value="Y";
      return false;
}

function ticTac(chk)
{
     if(chk.checked==true)
         document.getElementById("ctl00$MyCPH1$txtflag").value="Y";
     else     
         document.getElementById("ctl00$MyCPH1$txtflag").value="N";
}   


function validateFields()
{
        var txttypecode=document.getElementById("ctl00$MyCPH1$txtpaytypecode");
        var txtshortdesc=document.getElementById("ctl00$MyCPH1$txtshortdesc");

        if(txttypecode.value=="")
        {
            alert("Enter Type Code Properly.....");
            txttypecode.focus();
            return false;
        }
        else if(txtshortdesc.value=="")
        {
            alert("Enter Short Description Properly.......");
            txttypecode.focus();
            return false;
        }
        else
        {
        if(typeCheck())
            return false;
        else
            {   
                if(confirm("Are You Sure You Want to add this Type Details........"))
                    {
                    
                    
     var findobj=false;
     findobj=GetXMLHttpObject();
    if(findobj)
    {
     var strpg="subPayTypeMaster.aspx?mode=check&typecode=" + txttypecode.value + "&sid=" + Math.random() + "&ss=" + Math.random();
     findobj.open("GET",strpg);
     findobj.onreadystatechange=function()
         {
             if((findobj.readyState==4) && (findobj.status==200))
                {
                  var  ress=findobj.responseText.toString().split("|");
                   if(ress[0]=="true")
                    {
                        alert("This Type Code Already Exists..........");
                        txttypecode.focus();
                        return false;
                    }
                    else if(ress[0]=="false")
                    {   
                        return true;
                    }
                }
         }
         
    findobj.send(null);
    }                   
                    
                    
                    
                    
                    
                    
                    }
                else
                    {return false;}
            }
        }   
        
}


    function typeCheck()
    {
    
     var txttypecode=document.getElementById("ctl00$MyCPH1$txtpaytypecode");
     var valtype=txttypecode.value;
     txttypecode.value=valtype.toUpperCase();
     valtype=txttypecode.value;
        if(valtype.length>3)
        {
            alert("Type Code Length Exceeds Limit of 3 Chars");
            txttypecode.value="";
            txttypecode.focus();
            return false;
        }
        
     var findobj=false;
     findobj=GetXMLHttpObject();
    if(findobj)
    {
     var strpg="subPayTypeMaster.aspx?mode=check&typecode=" + txttypecode.value + "&sid=" + Math.random() + "&ss=" + Math.random();
     findobj.open("GET",strpg);
     findobj.onreadystatechange=function()
         {
             if((findobj.readyState==4) && (findobj.status==200))
                {
                  var  ress=findobj.responseText.toString().split("|");
                   if(ress[0]=="true")
                    {
                        alert("This Type Code Already Exists..........");
                        txttypecode.focus();
                        return false;
                    }
                    else if(ress[0]=="false")
                    {   
                        return true;
                    }
                }
         }
         
    findobj.send(null);
    }
}


function GetXMLHttpObject()
  { 
      var xmlHttp;
      try
        {    
            xmlHttp=new XMLHttpRequest();    // Firefox, Opera 8.0+, Safari    
        }
      catch (e)
        {
            // Internet Explorer    
            try
              {  
                  xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");      
              }
            catch (e)
              {      
                try
                    {xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");}
                catch (e)
                    {
                        alert("Your browser does not support AJAX!");        
                        return false;        
                    }      
              }    
         }
         return xmlHttp;  
   }


</script>
<div align="center">
<br /><br /><br /><br /><br /><br /><br /><br /><br /><br />

<table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="85%">
       <tr class="bgbluegrey">
            <td class="blackfnt" colspan="4" align="Center">PAYMENT TYPE MASTER SCREEN</td>
        </tr>
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left">Payment Type Code : </td>
            <td class="blackfnt" align="left">
                <asp:TextBox ID="txtpaytypecode" runat="server"></asp:TextBox>
            </td>
            <td class="blackfnt" align="left">Active Flag :</td>
            <td class="blackfnt" align="left">
                <asp:CheckBox ID="chkflag" runat="server" />
                <asp:TextBox ID="txtflag" Width="50"  Text="N" Enabled="False" runat="server"></asp:TextBox>
            </td>
        </tr>
        
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left">Short Description : </td>
            <td class="blackfnt" align="left">
                <asp:TextBox ID="txtshortdesc" runat="server"></asp:TextBox>
            </td>
            <td class="blackfnt" align="left">Detailed Description :</td>
            <td class="blackfnt" align="left">
                <asp:TextBox ID="txtdetdesc" runat="server"></asp:TextBox>
            </td>
        </tr>
        
        <tr bgcolor="#ffffff">
            <td class="blackfnt" colspan="2" align="Right">
                <asp:Button ID="btnsubmit" OnClick="btnsubmit_Click" runat="server" Text="Submit" />
            </td>
            <td class="blackfnt" colspan="2" align="left">
                <asp:Button ID="btnreset" runat="server" Text="Reset" />
            </td>
        
        </tr>
        
 </table>       
 
 
</div>
</asp:Content>
