<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master"  AutoEventWireup="true" CodeFile="Add_acctGroups.aspx.cs" Inherits="GUI_admin_Accounts_masters_Acctgroup_Add_acctGroups" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<%--<script language="javascript" type="text/javascript" src="addGroupJS.js"></script>--%>
<script type="text/javascript" language="javascript" src="JScript.js"></script>
<script type="text/javascript" language="javascript">
function CheckData()
{
    var prefix = "ctl00_MyCPH1_";
    var dlstCategory = document.getElementById( prefix + "dlstCategory");   
    var txtGroupDesc = document.getElementById( prefix + "txtGroupDesc");   
    var hdnmanualgrouprule = document.getElementById( prefix + "hdnmanualgrouprule");   
    
    if (dlstCategory.value == '')
    {
        alert("Please Select Group Category !!")
        dlstCategory.focus();
        return false;
    }
    if(hdnmanualgrouprule.value == 'N')
    {
        var txtGroupCode = document.getElementById( prefix + "txtGroupCode");   
        if(txtGroupCode.value == '')
        {
            alert("Please Enter Group Code !!")
            txtGroupCode.focus();
            return false;
        }
    }
    if (txtGroupDesc.value == '')
    {
        alert("Please Enter Group Desc. !!")
        txtGroupDesc.focus();
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
           <td><img src="../../../images/clear.gif" width="15" height="10"></td>
        </tr>
        <tr> 
           <td><img src="../../../images/clear.gif" width="15" height="10"></td>
        </tr>
        <tr>
            <td>
                <Table  border="0" cellpadding="3" cellspacing="1" class="boxbg" style="width:7in"  align="Center" >
                    <tr  class="bgbluegrey" >
                    <td align="center"><b><font class="blackfnt"><STRONG>Add/Edit Accounts Group</STRONG></font>
		               </b> </td>
                    </tr>
                </Table>
           <br />
           <Table  border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width:7in;"  align="Center" >
               <tr  bgcolor="#ffffff"   >
                   <td align="Left" class="blackfnt" >
                       &nbsp;Group Code  </td>
                   <td align="Left" class="blackfnt">
                        <asp:Label ID="lblId"  Font-Bold="false"  CssClass="blackfnt" ForeColor="Red" runat="server"></asp:Label>  
                        <asp:HiddenField ID="hdntype" runat="server" />
                   </td>
               </tr>
               <tr bgcolor="#ffffff">
                    <td align="left">
                        <font class="blackfnt">&nbsp;Category</font></td>
                    <td align="left" class="blackfnt">
                       <asp:DropDownList ID="dlstCategory" CssClass="blackfnt" runat="server" AutoPostBack="true" OnSelectedIndexChanged="Change_Group" >
                                <asp:ListItem Selected="True" Value="">Select</asp:ListItem>
                                <asp:ListItem Value="ASS001">ASSET</asp:ListItem>
                                <asp:ListItem Value="EXP001">EXPENSE</asp:ListItem>
                                <asp:ListItem Value="INC001">INCOME</asp:ListItem>
                                <asp:ListItem Value="LIA001">LIABILITY</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr bgcolor="#ffffff">
                    <td align="left">
                       <font class="blackfnt">&nbsp;Group Code</font> </td>
                    <td align="left" class="blackfnt">
                        <asp:DropDownList  CssClass="blackfnt"  ID="ddrgroupcode" runat="server"></asp:DropDownList>
                    </td>
                </tr>
                <%--<tr bgcolor="#ffffff">
                    <td align="left"></td>
                    <td align="left" class="blckfnt"><font class="redfnt"><asp:CheckBox runat="server" ID="chkManualGrupCode" Checked="false" AutoPostBack="true" OnCheckedChanged="chkManualGrupCode_CheckedChanged"/> Check here to Enter Manual Code Same As System Code<br /></font></td>
                </tr>--%>
                <tr id="trManualGroupCode" bgcolor="#ffffff" runat="server">
                    <td align="left">
                       <font class="blackfnt">&nbsp;Manual Group Code</font> </td>
                    <td align="left" class="blackfnt">
                        <asp:TextBox ID="txtGroupCode" BorderStyle="Groove" runat="server" MaxLength="10" Width="100px" CssClass="blackfnt"></asp:TextBox>        
                        <asp:HiddenField ID="HdnGroupCode" runat="server" />
                    </td>
                </tr>
                <tr bgcolor="#ffffff">
                    <td align="Left" class="blackfnt" style="height: 24px" >&nbsp;Group Name </td>
                    <td align="Left" class="blackfnt" style="height: 24px" >
                        <asp:TextBox ID="txtGroupDesc" BorderStyle="Groove" onChange="javascript:this.value=this.value.toUpperCase();" CssClass="blackfnt" runat="server" Columns="50" MaxLength="100" Width="230px" ></asp:TextBox>
                    </td>
                </tr>
                </Table>
                <br />
                <Table align="center">
                    <tr>
                        <td align="center" colspan="2" class="blackfnt" >
                            <b><asp:Button ID="Submit" Text="Submit" runat="server" OnClick="Submit_Click" OnClientClick="javascript:return CheckData()" /></b> 
                            <asp:HiddenField ID="hdnmanualgrouprule" runat="server" />
                        </td>
                    </tr>
                </Table>
            </td>
          </tr>
        </table>
       </ContentTemplate>
   </asp:UpdatePanel>
 </div> 
</asp:Content>
