<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="PaymentTypeMaster.aspx.cs" Inherits="GUI_Octroi_ViewnPrint_TypeMast" %>


<asp:Content ContentPlaceHolderID="MyCPH1" ID="aaaa" runat="server">

<script type="text/javascript" language="javascript">

function validateFields()
{
    
        var txttypecode=document.getElementById("ctl00$MyCPH1$txtpaytypecode");
        var txtshortdesc=document.getElementById("ctl00$MyCPH1$txtshortdesc");

        if(txttypecode.value=="")
        {
            alert("Enter Type Code Properly.....");
            txttypecode.focus();
        }
        else if(txtshortdesc.value=="")
        {
            alert("Enter Short Description Properly.......");
            txttypecode.focus();
        }
}


    function typeCheck()
    {
    
     var findobj=false;
    if(findobj)
    {
     var strpg="subPayTypeMaster.aspx?typecode=" + txttypecode.value;
     findobj.open("GET",strpg);
     findobj.onreadystatechange=function()
         {
             if((findobj.readyState==4) && (findobj.status==200))
                {
                  var  ress=findobj.responseText.toString().split("|");
                  alert();
                }
         }
         
    findobj.send(null);
    }
    
//        var txttypecode=document.getElementById("ctl00$MyCPH1$txtpaytypecode");
//        var ajaxobj=GetXMLHttpObject();
//        var url="subPayTypeMaster.aspx?typecode=" + txttypecode.value;
//        
//       alert(url);
//       if(ajaxobj)
//       {
//            
//            ajaxobj.open("GET",url); 
//            ajaxobj.onreadystatechange=function()
//            {
//                if(ajaxobj.readyState==4) 
//                {
//                    alert(ajaxobj.readyState);
//                    alert(ajaxobj.status);
//                    if(ajaxobj.status==200)
//                         {
//                            var ss=ajaxobj.responseText;
//                            var s=ss.split("|");
//                            for(var i=0;i<s.length;i++)
//                                {
//                                    alert(s[i]);
//                                }
//                          }
//                }
//            }
//        
//         ajaxobj.send(null);
//        }
//        
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
                <asp:CheckBox ID="chkflag" Checked="true" runat="server" />
                <asp:TextBox ID="txtflag" Width="50"  Text="Yes" Enabled="False" runat="server"></asp:TextBox>
            </td>
        </tr>
        
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left">Short Description : </td>
            <td class="blackfnt" align="left">
                <asp:TextBox ID="lblshortdesc" runat="server"></asp:TextBox>
            </td>
            <td class="blackfnt" align="left">Detailed Description :</td>
            <td class="blackfnt" align="left">
                <asp:TextBox ID="lbldetdesc" runat="server"></asp:TextBox>
            </td>
        </tr>
        
        <tr bgcolor="#ffffff">
            <td class="blackfnt" colspan="2" align="Right">
                <asp:Button ID="btnsubmit" runat="server" Text="Submit" />
            </td>
            <td class="blackfnt" colspan="2" align="left">
                <asp:Button ID="btnreset" runat="server" Text="Reset" />
            </td>
        
        </tr>
        
 </table>       
 
 
</div>
</asp:Content>
