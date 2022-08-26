<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Add_Acccategory.aspx.cs" Inherits="GUI_admin_Accounts_masters_Accounts_Add_Acccategory" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript" src="../../../images/commonJs.js"></script>
<script language="javascript" type="text/javascript" src="../../../Js/add_accounts.js"></script>
<script language="javascript" type="text/javascript">
function checkExist()
{
    var txtAcccategory = document.getElementById("ctl00_MyCPH1_txtAcccategory");
    if(txtAcccategory.value == "")
    {
        alert("Plz Enter Account Category")
        txtAcccategory.focus();
        return false;
    }
    return true;
}
function CheckCategory(id,code,val)
{
   document.getElementById(id).value=document.getElementById(id).value.toUpperCase();
   var Catcode=document.getElementById(id);
   
   Catcode.value = Catcode.value.replace(/^\s+|\s+$/g, '');
   
   if(Catcode.value == "")
        return false;
   
   var findobj=false;
   findobj=GetXMLHttpObject();
   if(findobj)
   {
      var strpg="CheckExist.aspx?mode=Acccategory&accode=" + code + "&Code=" + Catcode.value + "&val=" + val + "&sid=" + Math.random();
      findobj.open("GET",strpg,true);
      findobj.onreadystatechange=function()
         {
             if(findobj.readyState==4 && findobj.status==200)
                {
                    var res=findobj.responseText.split("|");
                    if(res[0]=="true")
                    {
                        alert(res[1]);
                        //Catcode.value="";
                        Catcode.focus();
                        return false;
                    }
                   
                }
         }
     findobj.send(null);
    }
    return false;  
}
</script>
<div style="text-align: center; width: 8.0in">
    <asp:UpdatePanel ID="UpdatePanel2" runat="server"  UpdateMode="Conditional" RenderMode="Inline">
        <ContentTemplate>
            <br />
            <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                <ProgressTemplate>
                    <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px; -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                        <tr>
                            <td align="right"><img src="../../../images/loading.gif" alt="" /></td>
                            <td><font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font></td>
                        </tr>
                    </table>
                    <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px; background-color: #FFFFFF;
                        width: 100%; height: 100%; filter: Alpha(Opacity=50); opacity: .50; -moz-opacity: .50;"
                        runat="server">
                        <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                            left: 50%;" ID="Panel2" runat="server">
                        </asp:Panel>
                    </asp:Panel>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <br />
            <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="80%">
                <tr class="bgbluegrey">
                    <td align="center" colspan="2">
                        <font class="blackfnt"><b>Add/Edit Account Category </b></font>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left" style="width: 290px">
                        <font class="blackfnt">&nbsp;Account Category Code</font></td>
                    <td align="left">
                        &nbsp;<asp:TextBox ID="txtAcccategory" BorderStyle="groove" runat="server" MaxLength="20"></asp:TextBox>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left" style="width: 290px">
                        <font class="blackfnt">&nbsp;Active</font></td>
                    <td align="left">
                        <asp:CheckBox ID="chkActiveflag" runat="server" />
                    </td>
                </tr>
            </table>
            <br />
            <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="80%">
                <tr class="bgbluegrey">
                    <td align="center" colspan="2">
                        <font class="blackfnt">
                            <asp:Button ID="Button1" OnClick="btnsubmit" runat="server" OnClientClick="javascript:return checkExist()" BorderStyle="solid" BorderWidth="1px" Text="Submit" Width="50px"/>
                        </font>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</div>
</asp:Content>

