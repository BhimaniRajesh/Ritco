<%@ Page Language="C#"  MasterPageFile="~/GUI/MasterPage.master"  AutoEventWireup="true" CodeFile="Edit_Acccategory.aspx.cs" Inherits="GUI_admin_Accounts_masters_Accounts_Edit_Accounts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript">
    Form_name="ctl00$MyCPH1$";
    function Edit_code()
    {
        var level_list_value=document.getElementById(Form_name+"Cmd_Acccategory").value;
	    if(level_list_value=="")
	    {
	        alert("Please Select Account Category !!!");
		    document.getElementById(Form_name+"Cmd_Acccategory").focus();
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
    <tr> 
        <td><img src="../../../images/clear.gif" width="15" height="10" alt="" /></td>
    </tr>
    <tr> 
        <td><img src="../../../images/clear.gif" width="15" height="10" alt="" /></td>
    </tr>
    <tr>   
        <td>
            <table  border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width:7in"  align="Center" >
                <tr class="bgbluegrey" >
                    <td align="center" colspan="2" class="blackfnt" ><b>Quick Edit Account Category</b> </td>
                </tr>
                <tr  bgcolor="#ffffff">
                    <td align="right" class="blackfnt" width="250px">
                        Select Account Category&nbsp;
                    </td>
                    <td align="Left" class="blackfnt">
                        &nbsp;<asp:DropDownList ID="Cmd_Acccategory" runat="server" Width="200px"></asp:DropDownList>
                    </td>
                </tr>
                <tr bgcolor="#ffffff" > 
                    <td colspan="2"><img src="../../../images/clear.gif" width="15" height="10" alt=""></td>
                </tr>
                <tr class="bgbluegrey" >
                    <td align="center" colspan="2" class="blackfnt" >
                        <b><asp:Button ID="Submit" Text="Edit" CssClass="blackfnt" Width="1in" runat="server" OnClick="Edit_Click" /></b> 
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
