<%@ Page Language="C#"  MasterPageFile="~/GUI/MasterPage.master"  AutoEventWireup="true" CodeFile="Edit_acctGroups.aspx.cs" Inherits="GUI_admin_Accounts_masters_Acctgroup_Edit_acctGroups" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">


<script language="javascript" type="text/javascript">
Form_name="ctl00$MyCPH1$"
function Edit_code()
{             
    var Groupcode= document.getElementById(Form_name+"TxtGroupcode").value;
	if(Groupcode=="")
	{
				alert("Please enter Group Code!!!");
				document.getElementById(Form_name+"TxtGroupcode").focus();
				return false;
	}
	return  true; 
}
function Edit_code_2()
{
    var Groupcode= document.getElementById(Form_name+"dlstAccountsGroups").value;
    if(Groupcode=="")
	{
        alert("Please Select Group!!!");
		document.getElementById(Form_name+"dlstAccountsGroups").focus();
		return false;
	}	

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
     <table style="width:10in" border="0" cellpadding="0" cellspacing="0" align="left">
        <tr> 
            <td>&nbsp;</td>
        </tr>
        <%--<tr>
            <td><font class="blackfnt"><a href="../../../welcome.aspx"><font class="blklnkund"><strong>Module</strong></font></a><strong> &gt; </strong></font>
                <a href="#"><font class="blklnkund"><strong>Admin</strong> </font></a>
                <strong> &gt; </strong>
                <a href="../../finance_accounts.aspx"><font class="blklnkund"><strong>Finance & Accounts</strong> </font></a>
                &gt; <font class="bluefnt"><strong>Edit Accounts Group</strong> </font>
            </td>
        </tr>--%>
        <tr> 
            <td><img src="../../../images/clear.gif" width="15" height="10" alt="" /></td>
        </tr>
        <tr> 
            <td><img src="../../../images/clear.gif" width="15" height="10" alt="" /></td>
        </tr>
        <tr>   
            <td>
                <table  border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width:7in"  align="Center" >
                   <tr  class="bgbluegrey" >
                        <td align="center" colspan="2" class="blackfnt" ><b>Quick Edit Accounts Group</b> </td>
                   </tr>
                   <tr bgcolor="#ffffff">
                        <td align="Right" class="blackfnt" style="width: 200px"></td>
                        <td align="left" style="height: 21px">
                            <asp:RadioButton ID="radCompanycode" Text="Company Group Code" runat="server" Checked="true" GroupName="sysmangroup" OnCheckedChanged="showDetails" AutoPostBack="true" />
                            &nbsp;&nbsp;
                            <asp:RadioButton ID="radAcccode" Text="System Group Code" runat="server" GroupName="sysmangroup" OnCheckedChanged="showDetails" AutoPostBack="true" />
                        </td>
                    </tr>
                   <tr bgcolor="#ffffff">
                        <td align="Right" class="blackfnt" style="width: 190px"><asp:Label ID="lblaccheader" runat="server" Text="Enter Company Group Code : "></asp:Label>&nbsp; </td>
                        <td align="Left"  class="blackfnt">&nbsp;<asp:TextBox ID="TxtGroupcode" BorderStyle="Groove"  onChange="javascript:this.value=this.value.toUpperCase();" CssClass="blackfnt" runat="server" Columns="6" MaxLength="10" Width="107px" ></asp:TextBox> </td>
                   </tr>
                   <tr bgcolor="#ffffff" > 
                        <td colspan="2"><img src="../../../images/clear.gif" width="15" height="10" alt="" /></td>
                   </tr>
                   <tr  class="bgbluegrey" >
                        <td align="center" colspan="2" class="blackfnt" ><b><asp:Button ID="Submit" Text="Edit" CssClass="blackfnt" Width="1in" runat="server" OnClick="Edit_Click" /></b></td>
                   </tr>
                </table>
            </td>
        </tr>
        <tr> 
            <td><img src="../../../images/clear.gif" width="15" height="10" alt="" /></td>
        </tr>
        <tr> 
            <td><img src="../../../images/clear.gif" width="15" height="10" alt="" /></td>
        </tr>
        <tr> 
            <td><img src="../../../images/clear.gif" width="15" height="10" alt="" /></td>
        </tr>
        <tr> 
            <td><img src="../../../images/clear.gif" width="15" height="10" alt=""/></td>
        </tr>      
        <tr>
            <td>
                <table  border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width:7in"  align="Center" >
                    <tr class="bgbluegrey" >
                        <td align="center" colspan="2" class="blackfnt" ><b>Select Group for Edit</b> </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td align="Right" class="blackfnt">Select Main Group  : &nbsp;</td>
                        <td align="Left" class="blackfnt">
                              &nbsp;<asp:DropDownList ID="Cmd_MainGroups"  CssClass="blackfnt" runat="server" AutoPostBack="true"  OnSelectedIndexChanged="OnChangeMainGroup">
                                <asp:ListItem Value="">Select</asp:ListItem>
                                <asp:ListItem Value="ASSET">ASSET</asp:ListItem>
                                <asp:ListItem Value="EXPENSE">EXPENSE</asp:ListItem>
                                <asp:ListItem Value="INCOME">INCOME</asp:ListItem>
                                <asp:ListItem Value="LIABILITY">LIABILITY</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td align="Right" class="blackfnt" style="width: 190px" >Select Group : &nbsp;</td>
                        <td align="Left" class="blackfnt">  &nbsp;<asp:DropDownList ID="dlstAccountsGroups" runat="server" CssClass="blackfnt"  Width="3in"></asp:DropDownList>&nbsp;&nbsp;&nbsp;
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff" > 
                        <td colspan="2"><img src="../../../images/clear.gif" width="15" height="10" alt="" ></td>
                    </tr>
                    <tr  class="bgbluegrey" >
                        <asp:HiddenField ID="lastlevel" runat="server" Value="1" />        
                        <td align="center" colspan="2" class="blackfnt" ><b><asp:Button ID="Edit_2" Text="Edit" CssClass="blackfnt" Width="1in" runat="server" OnClick="Edit_2_Click" />&nbsp;&nbsp;&nbsp;</b></td>
                    </tr>
                </table>
            </td>
            </tr>
        </table>
      </ContentTemplate>
   </asp:UpdatePanel>    
</div>
</asp:Content>
