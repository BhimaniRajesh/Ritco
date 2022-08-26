<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"  CodeFile="PaymentTypeMasterEdit.aspx.cs" Inherits="GUI_Octroi_ViewnPrint_PaymentTypeMasterEdit" %>

<asp:Content ContentPlaceHolderID="MyCPH1" ID="cont1" runat="server">
<script type="text/javascript" language="javascript" src="dragndrop.js"></script>
<script type="text/javascript" language="javascript">
function openDiv(id,str)
{
    var obj=Object();
    var lblobj=Object();
    var ids="ctl00$MyCPH1$" +id;
    var lbl=document.getElementById(ids);
    
    lblobj.elNode=document.getElementById(ids);
    obj.elNode= document.getElementById("ctl00_MyCPH1_divedit");
    obj.elNode.style.display='block';

    var txttypecode=document.getElementById("ctl00$MyCPH1$txtedittypecode");
    var txtshortdesc=document.getElementById("ctl00$MyCPH1$txteditshortdesc");
    var txtdetdesc=document.getElementById("ctl00$MyCPH1$txteditdetdesc");
    var txtflag=document.getElementById("ctl00$MyCPH1$txteditflag");
    var chkflag=document.getElementById("ctl00$MyCPH1$chkeditflag");
    var hdncode=document.getElementById("ctl00$MyCPH1$hdncode");
    
    txttypecode.value="";
    txttypecode.disabled=true;
    txtshortdesc.value="";
    txtdetdesc.value="";
    txtflag.value="Y";
    hdncode.value="";
 
    chkflag.checked=true;
    
    var findobj=false;
    findobj=GetXMLHttpObject();
    if(findobj)
    {
     var strpg="subPayTypeMaster.aspx?mode=data&typecode=" + str + "&sid=" + Math.random();
     findobj.open("GET",strpg);
     findobj.onreadystatechange=function()
         {
             if((findobj.readyState==4) && (findobj.status==200))
                {
                  var  res=findobj.responseText.split("|");
                   txttypecode.value=res[0];
                   hdncode.value=res[0];
                   txtshortdesc.value=res[1];
                   txtdetdesc.value=res[2];
                   txtflag.value=res[3];
                  
                   if(res[3]=="Y")
                        chkflag.checked=true;
                   else
                        chkflag.checked=false;
                }
         }
         
    findobj.send(null);
    }
    
   return false;
}

function closeDiv()
{
    document.getElementById("ctl00_MyCPH1_divedit").style.display='none';
    return false;
}


function ticTac(chk)
{
     if(chk.checked==true)
         document.getElementById("ctl00$MyCPH1$txteditflag").value="Y";
     else     
         document.getElementById("ctl00$MyCPH1$txteditflag").value="N";
}   


function validateFields()
{
    
        var txtshortdesc=document.getElementById("ctl00$MyCPH1$txteditshortdesc");
        if(txtshortdesc.value=="")
        {
            alert("Enter Short Description Properly.......");
            txttypecode.focus();
            return false;
        }
       
        if(confirm("Are You Sure You want to Update this Payment Type Code.......?"))
            return true;
        else
        {
            document.getElementById("ctl00$MyCPH1$txteditshortdesc").select();
            document.getElementById("ctl00$MyCPH1$txteditshortdesc").focus();
            return false;
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
<br /><br />

    <asp:Table ID="Table1" runat="server" CellPadding="3" CellSpacing="1" CssClass="boxbg" Width="80%">
        <asp:TableRow CssClass="bgbluegrey">
            <asp:TableCell CssClass="blackfnt">Payment Type Master</asp:TableCell>
        </asp:TableRow>
    </asp:Table>
    <br /><br />
    
      <asp:Table ID="Table2" runat="server" CellPadding="3" CellSpacing="1" CssClass="boxbg" Width="80%">
        <asp:TableRow CssClass="bgbluegrey">
            <asp:TableCell CssClass="blackfnt" HorizontalAlign="Right">
                <asp:Button ID="btnadd" runat="server" OnClick="btnadd_Click" Text="Add New" />
            </asp:TableCell>
        </asp:TableRow>
    </asp:Table>
    <br /><br />

    <asp:Table ID="tbltypelist" runat="server" CellPadding="3" CellSpacing="1" CssClass="boxbg" Width="80%">
        <asp:TableRow CssClass="bgbluegrey">
            <asp:TableCell CssClass="blackfnt">Serial No.</asp:TableCell>
            <asp:TableCell CssClass="blackfnt">Type Code</asp:TableCell>
            <asp:TableCell CssClass="blackfnt">Short Description</asp:TableCell>
            <asp:TableCell CssClass="blackfnt">Active Flag</asp:TableCell>
            <asp:TableCell CssClass="blackfnt">Remove</asp:TableCell>
        </asp:TableRow>
    </asp:Table>
<br /><br />

    <asp:Table ID="Table3" runat="server" CellPadding="3" CellSpacing="1" CssClass="boxbg" Width="80%">
        <asp:TableRow BackColor="#ffffff">
            <asp:TableCell>
                <asp:Button ID="btndone" runat="server" OnClick="btndone_Click" Text="Done"  AccessKey="S" />
            </asp:TableCell>
        </asp:TableRow>
    </asp:Table>

</div>

<asp:Panel runat="server" style="width:60%;display :none;top:250px; left:180px; position:absolute; border :solid #808080 1px;"  CssClass="boxbg" ID="divedit">
    <table bgcolor="#808080" border="0" style="position:relative;" cellpadding="3" cellspacing="1" class="boxbg" width="100%">
       <tr class="bgbluegrey">
            <td class="blackfnt" colspan="4" align="Center"><asp:Label ID="lbleditscreen" runat="server">PAYMENT TYPE MASTER SCREEN</asp:Label> </td>
        </tr>
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left">Payment Type Code : </td>
            <td class="blackfnt" align="left">
                <asp:TextBox ID="txtedittypecode" runat="server"></asp:TextBox>
            </td>
            <td class="blackfnt" align="left">Active Flag :</td>
            <td class="blackfnt" align="left">
                <asp:CheckBox ID="chkeditflag" runat="server" />
                <asp:TextBox ID="txteditflag" Width="50" Enabled="False" runat="server"></asp:TextBox>
            </td>
        </tr>
        
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left">Short Description : </td>
            <td class="blackfnt" align="left">
                <asp:TextBox ID="txteditshortdesc" runat="server"></asp:TextBox>
            </td>
            <td class="blackfnt" align="left">Detailed Description :</td>
            <td class="blackfnt" align="left">
                <asp:TextBox ID="txteditdetdesc" runat="server"></asp:TextBox>
            </td>
        </tr>
        
        <tr bgcolor="#ffffff">
            <td class="blackfnt" colspan="2" align="Right">
                <asp:UpdatePanel runat="server" ID="uppfff">
                    <ContentTemplate>
                <asp:Button ID="btnupdate" OnClick="btnupdate_Click" runat="server" Text="Submit" />
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
            <td class="blackfnt" colspan="2" align="left">
                <asp:Button ID="btncancel" runat="server" Text="cancel" />
            </td>
        
        </tr>
    </table>       
</asp:Panel>

<asp:HiddenField runat="server" ID="hdncode" />
</asp:Content>
