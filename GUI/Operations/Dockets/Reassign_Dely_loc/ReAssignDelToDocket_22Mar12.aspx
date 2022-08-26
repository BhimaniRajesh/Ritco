<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="ReAssignDelToDocket.aspx.cs" Inherits="GUI_admin_RouteMaster_RouteMaster"
    Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
<script language="javascript" type="text/javascript" src="../../../images/commonJs.js"></script>
    <script language="javascript" type="text/javascript">
    function checkrows()
    {
        var txtrows=document.getElementById("ctl00_MyCPH1_TxtRows");
        if (txtrows.value == "")
            return false;
        if(isNaN(txtrows.value))
        {
            txtrows.value="1";
            alert("Please Enter Valid Number of Rows...");
            return false;
        }
        return true;
    }
    
    
    function clickSubmit()
    {
           var hdnajaxstate=document.getElementById("ctl00_MyCPH1_hdnajaxstate");
           if(hdnajaxstate.value=="1")
           {
                alert("Let the Internal Processes Over.Try after sometime or LogOn again..");
                return false;
           }
           
            var rows = document.getElementById("ctl00_MyCPH1_grvdocket").rows.length;
            var pref="";
            rows=parseInt(rows)+1;
            for(var i=2;i<rows;i++)
            {
                if(i<10)
                    pref="ctl00_MyCPH1_grvdocket_ctl0" + i + "_"
                else
                    pref="ctl00_MyCPH1_grvdocket_ctl" + i + "_"
               
                var txtdockno=document.getElementById(pref + "txtdockno");
                var txtdelloc=document.getElementById(pref + "txtdelloc");
                var txtnextloc=document.getElementById(pref + "txtnextloc");
                
                    if (txtdockno.value == "")
                    {
                        alert("Please Enter Docket Number");
                        txtdockno.focus();
                        return false;
                    }
                    
                    if (txtdelloc.value == "")
                    {
                        alert("Please Enter Delivery Location");
                        txtdelloc.focus();
                        return false;
                    }
                    
                    if (txtnextloc.value == "")
                    {
                        alert("Please Enter Next Location");
                        txtnextloc.focus();
                        return false;
                    }
                    
                    var Jpref="";
                    for(var j=2;j<rows;j++)
                    {
                        if(j<10)
                            Jpref="ctl00_MyCPH1_grvdocket_ctl0" + j + "_"
                        else
                            Jpref="ctl00_MyCPH1_grvdocket_ctl" + j + "_"
                            
                            var txtJdockno=document.getElementById(Jpref + "txtdockno");
                            if(i!=j)
                            {
                             
                             if (txtdockno.value == txtJdockno.value)
                                {
                                    alert("Duplicate Docket Nos Found");
                                    txtdockno.value="";
                                    txtdockno.focus();
                                    return false;
                                }
                            }
                    }
           }
           
           return true;
    }
    
    
    
    function openpopUp(id)
    {
        window.open("DataPopUp.aspx?poptp=delloc&code1=" + id + "&code2=",null,"menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        return false
    }
        
     
         
 
function locTest(txtid,tp)
{

    var hdnajaxstate=document.getElementById("ctl00_MyCPH1_hdnajaxstate");
	    hdnajaxstate.value="1";

    var hdnclient=document.getElementById("ctl00_MyCPH1_hdnclient");
    
    var txt=document.getElementById(txtid);
    if(txt.value=="") 
    {   
        hdnajaxstate.value="0";
        return false;
    }
    
    txt.value=txt.value.toUpperCase();
    
    var findobj=false;
    findobj=GetXMLHttpObject();
    if(findobj)
    {
        if(tp=="delloc")
            var strpg="AjaxResponse.aspx?mode=check&code1=delloc&code2=" + txt.value + "&sid=" + Math.random() + "&sid=" + Math.random();
        else
            var strpg="AjaxResponse.aspx?mode=check&code1=loctest&code2=" + txt.value + "&sid=" + Math.random() + "&sid=" + Math.random();
     findobj.open("GET",strpg);
     findobj.onreadystatechange=function()
         {
             if((findobj.readyState==4) && (findobj.status==200))
                {
                  var  res=findobj.responseText.split("|");
                  
                  if(res[0]=="false")
                     {
                        if(tp=="delloc")
                            {
                                if(hdnclient.value=="RLL")
                                    {
                                        alert("This Location doesn't Exists or Regional Office or HeadOffice.");
                                    }
                                else
                                    alert("This Location doesn't Exists ");
                             }
                        else
                            alert("This Location doesn't Exists ");
                        txt.value="";
                        txt.focus();
                        hdnajaxstate.value="0";
                        return false;
                     }
                  else if(res[0]=="true")
                  {
                    hdnajaxstate.value="0";
                  }
             }
         }
         
    findobj.send(null);
    }

   return true;
}



function dockNoBlur(txtid)
{

    var hdnajaxstate=document.getElementById("ctl00_MyCPH1_hdnajaxstate");
	    hdnajaxstate.value="1";

    var hdnclient=document.getElementById("ctl00_MyCPH1_hdnclient");
    var txt=document.getElementById(txtid);
    txt.value=txt.value.toUpperCase();
        
    if(txt.value=="") 
    {   
        hdnajaxstate.value="0";
        return false;
    }

    var prefid="",delid="",nextid="";

    var len=txtid.length;
    len=parseFloat(len)-9;

    prefid=prefid+txtid.substring(0,len)
    
    var txtdelloc=document.getElementById(prefid+"txtdelloc");
    var txtnextloc=document.getElementById(prefid+"txtnextloc");
   
    var findobj=false;
    findobj=GetXMLHttpObject();
    if(findobj)
    {

     var strpg="AjaxResponse.aspx?mode=data&code1=dockno&code2=" + txt.value + "&sid=" + Math.random() + "&sid=" + Math.random();
     findobj.open("GET",strpg);
     findobj.onreadystatechange=function()
         {
             if((findobj.readyState==4) && (findobj.status==200))
                {
                  var res=findobj.responseText.split("|");
                      if(res[0]=="false")
                       {
                            alert("Docket Not Found");
                            txt.focus();
                            txt.value="";
                            hdnajaxstate.value="0";
                            return false;
                       }
                      else if(res[0]=="true")
                      {
                        txtdelloc.value=res[1];
                        txtnextloc.value=res[2];
                        hdnajaxstate.value="0";
                      }
                }
         }
         
    findobj.send(null);
    }

   return true;
}


    </script>

        <table style="width: 1000px">
            <tr>
                <td align="left">
                    <a><font class="blklnkund"><b>Exceptions</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                        <b></b></font></a><a href="../../../admin/operations.aspx"><font class="blklnkund"><b>
                            Operations</b></font></a> <b>&gt; </b><font class="bluefnt"><b>Re-Assign Delivery Location
                                To Docket</b></font>
                </td>
            </tr>
        </table>
        <br />
        <asp:UpdatePanel ID="UpdatePanel3" runat="server"  UpdateMode="Conditional" RenderMode="Inline">
            <ContentTemplate>
                <table class="boxbg" style="width: 10in" border="0" cellpadding="0" cellspacing="1">
                    <tr bgcolor="white">
                        <td align="center" class="blackfnt">
                                <asp:Label ID="label1" runat="server" CssClass="blackfnt" Text="Enter Number Of Rows :"></asp:Label>
                                <asp:TextBox ID="TxtRows" runat="server" BorderStyle="Groove" MaxLength="2" CssClass="blackfnt" onblur="javascript:return checkrows(this)"
                                   style="text-align:right;" Width="44px"></asp:TextBox>
                            <asp:Button ID="CmdAddRows" CausesValidation="false" OnClientClick="return checkrows()"
                                runat="server" OnClick="CmdAddRows_Click" CssClass="blackfnt" Text="Add Rows" Width="66px" />
                        </td>
                    </tr>
                    <tr bgcolor="White">
                        <td>
                            <asp:GridView Width="10in" style="margin:1px 1px 1px 1px;" ID="grvdocket" runat="server" AutoGenerateColumns="false"
                                CssClass="boxbg" HeaderStyle-CssClass="bgbluegrey" 
                                OnRowDataBound="grvdocket_RowDataBound" PagerStyle-Mode="NumericPages" PageSize="10"
                                SelectedIndex="1" CellPadding="0" CellSpacing="1" BorderWidth="0">
                                <Columns>
                                    <asp:TemplateField HeaderText="Serial No.">
                                        <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                        <ItemStyle BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblsrno" runat="server" CssClass="blackfnt" Text="<%# Container.DataItemIndex+1 %>"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Docket Number">
                                        <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                        <ItemStyle BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtdockno" BorderStyle="Groove" MaxLength="15" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Reassign Delivery Location To">
                                        <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                        <ItemStyle BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtdelloc" BorderStyle="Groove" runat="server" MaxLength="7"></asp:TextBox>
                                            <asp:Button ID="btndelloc" CssClass="blackfnt" Text="...." runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Reassign Next Location To">
                                        <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                        <ItemStyle BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtnextloc" BorderStyle="Groove" runat="server" MaxLength="7"></asp:TextBox>
                                            <asp:Button ID="btnnextloc" CssClass="blackfnt" Text="...." runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle CssClass="bgbluegrey" />
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr class="bgbluegrey">
                        <td align="center">
                        <asp:Button ID="btnUpdt" OnClientClick="javascript:return clickSubmit()" runat="server" Text="Submit" OnClick="btnUpdt_Click" />
                        </td>
                    </tr>
                </table>
                <asp:HiddenField ID="hdnajaxstate" runat="server" Value="0" />
                 <asp:HiddenField ID="hdnclient" runat="server" Value="0" />
            </ContentTemplate>
        </asp:UpdatePanel>
</asp:Content>
