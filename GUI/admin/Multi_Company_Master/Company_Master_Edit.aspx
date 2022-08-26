<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Company_Master_Edit.aspx.cs" Inherits="GUI_admin_Multi_Company_Master_Company_Master_Edit"  %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>
<script language="javascript" type="text/javascript">
Form_name="ctl00$MyCPH1$"
function Edit_code()
{             
    var TxtCmpCode= document.getElementById(Form_name+"TxtCmpCode");
    var Cmd_comlist= document.getElementById(Form_name+"Cmd_comlist");
	if(TxtCmpCode.value == "")
	{   
	    if(Cmd_comlist.value == "")
	    {
	        alert("Please Select The Company!!!");
		    document.getElementById(Form_name+"Cmd_comlist").focus();
		    return false;
		}
    }
    return  true; 
}
function CompanyCode(id)
{  
    var str="";
    for(var i=0;i<id.length-14;i++)
    {
        str+=id.charAt(i);
    }
    document.getElementById(id).value=document.getElementById(id).value.toUpperCase()
    var txtCompanyCode=document.getElementById(id);
    
    var CompanyCode = txtCompanyCode.value;
    if(CompanyCode == "")
        return false;
 
    var findobj=false;
    findobj=GetXMLHttpObject();
    if(findobj)
    {
        var strpg="CheckExist.aspx?mode=Company&Code=" + CompanyCode + "&sid=" + Math.random();
        findobj.open("GET",strpg,true);
        findobj.onreadystatechange=function()
        {
             if(findobj.readyState==4 && findobj.status==200)
              {
                    var res=findobj.responseText.split("|");
                    if(res[0]=="false")
                    {
                        alert("Company Code Is Not Exists... Please Enter Valid Company Code");
                        txtCompanyCode.value="";
                        txtCompanyCode.focus();
                        return false;
                    }
              }
         }
    findobj.send(null);
    }
    return false;
}
</script>
<div>
<asp:UpdatePanel ID="up1" runat="server">
    <ContentTemplate>
    <br />
        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
            <ProgressTemplate>
                <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px; -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                    <tr>
                        <td align="right"><img src="../../images/loading.gif" alt="" /></td>
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
    <table style="width:10in" border="0" cellpadding="0" cellspacing="0" align="left">
    <tr> 
        <td>&nbsp;</td>
    </tr>
    <tr> 
        <td><img src="../../images/clear.gif" width="15" height="10" alt="" /></td>
    </tr>
    <tr> 
        <td><img src="../../images/clear.gif" width="15" height="10" alt="" /></td>
    </tr>
    <tr>   
        <td>
            <table  border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width:7in"  align="Center" >
                <tr class="bgbluegrey" >
                    <td align="center" colspan="2" class="blackfnt" ><b>Quick Edit Company Master</b> </td>
                </tr>
                <tr  bgcolor="#ffffff"   >
                    <td align="Right" class="blackfnt" style="width: 200px"><asp:Label ID="lblaccheader" runat="server" Text="Enter Company Code : "></asp:Label>&nbsp;&nbsp; </td>
                    <td align="Left" class="blackfnt">&nbsp;<asp:TextBox ID="TxtCmpCode"  onChange="javascript:this.value=this.value.toUpperCase();" CssClass="input" runat="server" Columns="10" MaxLength="50" Width="100px" ></asp:TextBox> </td>
                </tr>
                <tr bgcolor="#ffffff" > 
                    <td colspan="2" align="center"><asp:Label ID="lbltxt" Text="OR" runat="server" Font-Bold="true"></asp:Label></td>
                </tr>
                <tr bgcolor="#ffffff" > 
                    <td align="center" class="blackfnt">Select Company Code</td>
                    <td align="Left" class="blackfnt"  >
                        &nbsp;<asp:DropDownList DataTextField=NAME DataValueField=CODE ID="Cmd_comlist" runat="server" Width="200px">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr bgcolor="#ffffff" > 
                    <td align="center" colspan="2" class="bgbluegrey" >
                         <b><asp:Button ID="Submit" Text="Edit" CssClass="blackfnt" Width="1in" runat="server" OnClientClick="javascript:return Edit_code()" OnClick="Edit_Click" />
                    </td>
                </tr>
             </table>
       </td>
    </tr>
    </table>
    </ContentTemplate>
</asp:UpdatePanel>
</div>
</asp:Content>

