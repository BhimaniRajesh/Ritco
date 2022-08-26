<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="EnterUpdates.aspx.cs" Inherits="GUI_admin_Updates_EnterUpdates" %>



<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<script type="text/javascript" language="javascript">
function validateText()
{
    if(document.getElementById("ctl00_MyCPH1_txtupdates").value=="")
        {
            alert("Please Enter Details");
            document.getElementById("ctl00_MyCPH1_txtupdates").focus();
            return false;
        }
    else
        return true;    
    
}


function setRowNum(pansel)
{
    var colorpan=document.getElementById("ctl00_MyCPH1_divcolorpan");
    colorpan.style.display='block';
    
    
    var curleft=0,curtop=0;
    var colorbar=document.getElementById(pansel);
  
     if(colorbar.offsetParent)
       {
            curleft+=colorbar.offsetLeft;
            curtop+=colorbar.offsetTop;
            while(colorbar.offsetParent)
            {
                colorbar=colorbar.offsetParent;
                curleft+=colorbar.offsetLeft;
                curtop+=colorbar.offsetTop;
            }
       }
      
    
    colorpan.style.left= (curleft + 60) + 'px';
    var t1=curtop+15;
    colorpan.style.top= t1 + 'px';
   return false;
}

</script>


                                 <%--Back Link To First Page in Viewing Agent Bills--%>
                                 <table width="80%" border="0" align="left" cellpadding="0" cellspacing="0">
    	<tr> 
          <td height="30"><font class="blklnkund"><strong> Module</strong></font>
          
		<strong> &gt; </strong><font class="blklnkund"><strong>Admini</strong></font>



<font class=bluefnt><strong> &gt; </strong>
		  <strong>Updates </strong> </font></td>
        </tr>
       
   
        
        
                    <tr> 
                      <td height="300" valign="top">
    
 
    <br />
    <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td align="right" style="height: 33px">
                <a href="javascript:window.history.go(-1)" title="back">
                <img  alt="back.gif" border="0" src="../../images/back.gif" /></a>
            </td>
        </tr>
    </table>
    

<br /><br />

 <div align="center">

 <asp:UpdatePanel ID="UpdatePanel1" runat="server"  UpdateMode="Conditional" RenderMode="Inline">
       <ContentTemplate>
     
    <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="60%">
        <tr class="bgbluegrey">
            <td colspan="3" class="blackfnt" align="center">Update Detail</td>
        </tr>
        <tr bgcolor="#ffffff">
            <td class="blackfnt" width="100px" align="left">Enter Details</td>
            <td class="blackfnt" align="left" valign="middle">
                <asp:TextBox ID="txtupdates" runat="server" Width="300px" Height="40px" BorderStyle="Groove" TextMode="MultiLine"></asp:TextBox>
                 <asp:TextBox ID="txtnews_colorname" style="display:none;" runat="server"></asp:TextBox>
            </td>
            <td class="blackfnt" align="center">
                       <asp:Button ID="btncolbar" BorderStyle="Groove" runat="server" BackColor="black" Width="100px" Height="15px" />
                      
        </td>
        </tr>
       
        <tr bgcolor="#ffffff">
            <td align="center" colspan="3">
                <asp:Button ID="btnsubmit" OnClick="btnsubmit_Click" Text="Submit" runat="server" />
            </td>
       </tr>
    </table>
 
     <asp:Panel runat="server" ID="divcolorpan" style="top:200px;display:none;position:absolute; background-color:White;border:solid 1px black;size:auto;">
                            <asp:Table runat="server" ID="tblcolorpan" style="margin:2px 2px 2px 2px;">
                             
                            </asp:Table>
                       </asp:Panel>
      
           </ContentTemplate>
</asp:UpdatePanel>
<br />
 
    <asp:HiddenField ID="hdnrows" runat="server" Value="5" />
    <asp:HiddenField ID="hdncolor" runat="server" />
    </div>
    </td>
                    </tr>
                    <tr> 
                      <td>&nbsp;</td>
                    </tr>
                    <tr>
                      <td></td>
                    </tr>
                  </table>
</asp:Content>
